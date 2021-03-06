// Neptune Mutual Protocol (https://neptunemutual.com)
// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.0;
import "../base/MockStore.sol";
import "../base/MockProtocol.sol";
import "./MockVault.sol";
import "../../libraries/ProtoUtilV1.sol";

library MockProcessorStoreLib {
  function initialize(
    MockStore s,
    bytes32 key,
    address cxToken
  ) external returns (address[] memory values) {
    MockProtocol protocol = new MockProtocol();
    MockVault vault = new MockVault();

    s.setAddress(ProtoUtilV1.CNS_CORE, address(protocol));
    s.setAddress(ProtoUtilV1.CNS_COVER_STABLECOIN, cxToken);

    s.setBool(ProtoUtilV1.NS_COVER_CXTOKEN, cxToken);
    s.setBool(ProtoUtilV1.NS_MEMBERS, cxToken);
    s.setUint(ProtoUtilV1.NS_GOVERNANCE_REPORTING_INCIDENT_DATE, key, 1234);

    s.setBool(ProtoUtilV1.NS_MEMBERS, address(vault));
    s.setAddress(ProtoUtilV1.NS_CONTRACTS, "cns:cover:vault", key, address(vault));

    setCoverStatus(s, key, 4);
    setClaimBeginTimestamp(s, key, block.timestamp - 100 days); // solhint-disable-line
    setClaimExpiryTimestamp(s, key, block.timestamp + 100 days); // solhint-disable-line

    values = new address[](2);

    values[0] = address(protocol);
    values[1] = address(vault);
  }

  function disassociateCxToken(MockStore s, address cxToken) external {
    s.unsetBool(ProtoUtilV1.NS_COVER_CXTOKEN, cxToken);
  }

  function setCoverStatus(
    MockStore s,
    bytes32 key,
    uint256 value
  ) public {
    s.setUint(ProtoUtilV1.NS_COVER_STATUS, key, value);
  }

  function setClaimBeginTimestamp(
    MockStore s,
    bytes32 key,
    uint256 value
  ) public {
    s.setUint(ProtoUtilV1.NS_CLAIM_BEGIN_TS, key, value);
  }

  function setClaimExpiryTimestamp(
    MockStore s,
    bytes32 key,
    uint256 value
  ) public {
    s.setUint(ProtoUtilV1.NS_CLAIM_EXPIRY_TS, key, value);
  }
}

contract MockProcessorStore is MockStore {
  function initialize(bytes32 key, address cxToken) external returns (address[] memory values) {
    return MockProcessorStoreLib.initialize(this, key, cxToken);
  }

  function disassociateCxToken(address cxToken) external {
    MockProcessorStoreLib.disassociateCxToken(this, cxToken);
  }

  function setCoverStatus(bytes32 key, uint256 value) external {
    MockProcessorStoreLib.setCoverStatus(this, key, value);
  }

  function setClaimBeginTimestamp(bytes32 key, uint256 value) external {
    MockProcessorStoreLib.setClaimBeginTimestamp(this, key, value);
  }

  function setClaimExpiryTimestamp(bytes32 key, uint256 value) external {
    MockProcessorStoreLib.setClaimExpiryTimestamp(this, key, value);
  }
}
