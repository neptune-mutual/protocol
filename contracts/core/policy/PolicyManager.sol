// Neptune Mutual Protocol (https://neptunemutual.com)
// SPDX-License-Identifier: BUSL-1.1
pragma solidity >=0.4.22 <0.9.0;
import "../../interfaces/IMember.sol";
import "../Recoverable.sol";

abstract contract PolicyManager is IMember, Recoverable {}