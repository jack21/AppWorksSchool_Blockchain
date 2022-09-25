// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ABDKMath64x64.sol";
import "./ABDKMathQuad.sol";

contract ABDKMath {
    // 第一種寫法：計算 x 的 3.5%，計算過程是 x * 35 / 1000，輸入 1000 結果是 35
    function percent(uint256 x) external pure returns (uint256) {
        int128 result = ABDKMath64x64.div( // 用內建的 function 做運算
            ABDKMath64x64.mul( // 用內建的 function 做運算
                ABDKMath64x64.fromUInt(x), // 使用時，所有的數字要先轉成 int128，也就是 signed 64.64
                ABDKMath64x64.fromUInt(35) // 使用時，所有的數字要先轉成 int128，也就是 signed 64.64
            ),
            ABDKMath64x64.fromUInt(1000) // 使用時，所有的數字要先轉成 int128，也就是 signed 64.64
        );
        return ABDKMath64x64.toUInt(result); // 最後轉回一般的 uint，這裡會取整數，失去精準度，但起碼運算過程精準度比較不會消失
    }

    // 第二種寫法：一樣計算 x 的 3.5%，但是計算過程改成先計算出 3.5%，再把輸入的 x 成上 3.5%，結果輸入 1000 結果是 34，失去精準度
    function percentABDKMath(uint256 x) external pure returns (uint256) {
        // 先計算出 3.5%
        int128 percentage = ABDKMath64x64.div(
            ABDKMath64x64.fromUInt(35),
            ABDKMath64x64.fromUInt(1000)
        );
        int128 result = ABDKMath64x64.mul(
            ABDKMath64x64.fromUInt(x),
            percentage
        );
        return ABDKMath64x64.toUInt(result);
    }

    // 第三種寫法：跟第二種方式一樣，只是 Library 換成 ABDKMathQuad，結果輸入 1000 結果是 34，失去精準度
    function percentABDKMathQuad(uint256 x) external pure returns (uint256) {
        // 先計算出 3.5%
        bytes16 percentage = ABDKMathQuad.div(
            ABDKMathQuad.fromUInt(35),
            ABDKMathQuad.fromUInt(1000)
        );
        bytes16 result = ABDKMathQuad.mul(
            ABDKMathQuad.fromUInt(x),
            percentage
        );
        return ABDKMathQuad.toUInt(result);
    }
}
