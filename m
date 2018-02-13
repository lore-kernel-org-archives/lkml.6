Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965595AbeBMTmS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:42:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:4411 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965313AbeBMTmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:42:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="34416284"
Date: Wed, 14 Feb 2018 03:41:57 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [tip:x86/urgent 14/14]
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: sparse: incorrect type
 in argument 1 (different base types)
Message-ID: <201802140355.Dy4ldN8E%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
head:   0fc8483b698620ea3d8cc6635b54eccc613c23a3
commit: 0fc8483b698620ea3d8cc6635b54eccc613c23a3 [14/14] x86/io: Define readq()/writeq() to use 64-bit type
reproduce:
        # apt-get install sparse
        git checkout 0fc8483b698620ea3d8cc6635b54eccc613c23a3
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1214:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1214:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1214:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1214:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1214:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1218:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1218:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1218:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1218:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1218:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1218:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1219:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1219:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1219:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1219:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1219:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1219:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1223:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1223:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1223:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1223:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1223:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1223:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1230:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1230:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1230:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1230:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1230:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1230:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1262:17: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1262:17: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1262:17: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1262:17: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1262:17: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1262:17: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1269:17: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1269:17: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1269:17: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1269:17: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1269:17: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1269:17: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1500:29: sparse: cast to restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1501:34: sparse: cast to restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1503:34: sparse: cast to restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1505:39: sparse: cast to restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1559:36: sparse: cast to restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1574:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1574:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1574:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1574:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1574:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1574:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1576:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1576:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1576:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1576:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1576:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1576:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1582:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1582:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1582:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1582:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1582:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1582:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1584:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1584:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1584:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1584:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1584:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1584:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1681:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1681:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1681:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1681:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1681:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1681:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1683:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1683:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1683:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1683:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1683:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1683:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1685:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1685:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1685:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1685:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1685:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1685:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1686:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1686:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1686:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1686:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1686:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1686:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1687:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1687:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1687:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1687:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1687:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1687:9: right side has type restricted __le32
>> drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got nsigned long long val @@
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: expected unsigned long long val
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: got restricted __le64 <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1691:22: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got nsigned long long val @@
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1691:22: expected unsigned long long val
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1691:22: got restricted __le64 <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1692:22: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1692:22: expected unsigned int val
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1692:22: got restricted __le32 <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1696:22: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1696:22: expected unsigned int val
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1696:22: got restricted __le32 <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1719:18: sparse: cast to restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1719:18: sparse: cast from restricted __be32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1788:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1788:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1788:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1788:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1788:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1788:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1803:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1803:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1803:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1803:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1803:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1803:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1850:32: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 virt_addr_l @@ got unsignrestricted __le32 virt_addr_l @@
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1850:32: expected restricted __le32 virt_addr_l
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1850:32: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1851:32: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 virt_addr_h @@ got unsignrestricted __le32 virt_addr_h @@
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1851:32: expected restricted __le32 virt_addr_h
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1851:32: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1852:27: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 length @@ got unsignrestricted __le32 length @@
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1852:27: expected restricted __le32 length
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1852:27: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1884:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1890:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1894:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1900:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1904:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1910:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1914:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1921:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1927:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1931:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1937:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1941:25: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1953:31: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 pbl_addr_l @@ got unsignrestricted __le32 pbl_addr_l @@
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1953:31: expected restricted __le32 pbl_addr_l
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1953:31: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1988:9: sparse: too many warnings
--
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:482:37: sparse: incorrect type in argument 1 (different base types) @@ expected restricted __be32 @@ got restricted __be32 @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:482:37: expected restricted __be32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:482:37: got restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:577:37: sparse: incorrect type in argument 1 (different base types) @@ expected restricted __be32 @@ got restricted __be32 @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:577:37: expected restricted __be32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:577:37: got restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:805:18: sparse: restricted __le16 degrades to integer
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:822:34: sparse: incorrect type in assignment (different base types) @@ expected unsigned short desc_ret @@ got short desc_ret @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:822:34: expected unsigned short desc_ret
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:822:34: got restricted __le16 retval
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:861:26: sparse: cast to restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:861:26: sparse: cast from restricted __le16
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:862:29: sparse: cast to restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:862:29: sparse: cast from restricted __le16
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1222:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1222:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1222:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1222:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1222:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1222:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1224:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1224:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1224:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1224:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1224:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1224:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1226:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1226:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1226:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1226:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1226:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1226:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1228:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1228:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1228:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1228:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1228:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1228:9: right side has type restricted __le32
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1231:22: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got nsigned long long val @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1231:22: expected unsigned long long val
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1231:22: got restricted __le64 <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1232:22: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got nsigned long long val @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1232:22: expected unsigned long long val
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1232:22: got restricted __le64 <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1237:22: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1237:22: expected unsigned int val
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1237:22: got restricted __le32 <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1238:22: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1238:22: expected unsigned int val
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1238:22: got restricted __le32 <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1308:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1308:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1308:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1308:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1308:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1308:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1329:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1329:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1329:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1329:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1329:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1329:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1360:39: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1374:39: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1378:36: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1395:38: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1421:36: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1432:38: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1479:33: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1603:38: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1608:38: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 cqe_cur_blk_addr @@ got unsignrestricted __le32 cqe_cur_blk_addr @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1608:38: expected restricted __le32 cqe_cur_blk_addr
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1608:38: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1610:33: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1612:9: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1621:38: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 cqe_nxt_blk_addr @@ got unsignrestricted __le32 cqe_nxt_blk_addr @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1621:38: expected restricted __le32 cqe_nxt_blk_addr
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1621:38: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1622:9: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1635:28: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 cqe_ba @@ got unsignrestricted __le32 cqe_ba @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1635:28: expected restricted __le32 cqe_ba
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1635:28: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1666:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1666:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1666:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1666:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1666:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1666:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1668:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1668:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1668:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1668:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1668:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1668:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1670:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1670:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1670:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1670:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1670:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1670:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1673:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1673:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1673:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1673:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1673:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1673:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1675:9: sparse: invalid assignment: &=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1675:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1675:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1675:9: sparse: invalid assignment: |=
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1675:9: left side has type unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1675:9: right side has type restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1678:28: sparse: incorrect type in argument 1 (different base types) @@ expected restricted __be32 @@ got 2 @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1678:28: expected restricted __be32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1678:28: got unsigned int
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2272:36: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 qkey_xrcd @@ got unsigned intrestricted __le32 qkey_xrcd @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2272:36: expected restricted __le32 qkey_xrcd
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2272:36: got unsigned int const qkey
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2586:36: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 qkey_xrcd @@ got unsigned intrestricted __le32 qkey_xrcd @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2586:36: expected restricted __le32 qkey_xrcd
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2586:36: got unsigned int const qkey
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2660:29: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 wqe_sge_ba @@ got unsignrestricted __le32 wqe_sge_ba @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2660:29: expected restricted __le32 wqe_sge_ba
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2660:29: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2723:34: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 rq_cur_blk_addr @@ got unsignrestricted __le32 rq_cur_blk_addr @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2723:34: expected restricted __le32 rq_cur_blk_addr
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2723:34: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2736:34: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 rq_nxt_blk_addr @@ got unsignrestricted __le32 rq_nxt_blk_addr @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2736:34: expected restricted __le32 rq_nxt_blk_addr
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2736:34: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2760:26: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 trrl_ba @@ got unsignrestricted __le32 trrl_ba @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2760:26: expected restricted __le32 trrl_ba
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2760:26: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2768:26: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 irrl_ba @@ got unsignrestricted __le32 irrl_ba @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2768:26: expected restricted __le32 irrl_ba
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2768:26: got unsigned int <noident>
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2779:9: sparse: cast from restricted __le32
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2947:34: sparse: incorrect type in assignment (different base types) @@ expected restricted __le32 sq_cur_blk_addr @@ got unsignrestricted __le32 sq_cur_blk_addr @@
   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:2947:34: expected restricted __le32 sq_cur_blk_addr
--
   drivers/scsi/mpt3sas/mpt3sas_base.c:861:42: sparse: incorrect type in assignment (different base types) @@ expected unsigned short Event @@ got short Event @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:861:42: expected unsigned short Event
   drivers/scsi/mpt3sas/mpt3sas_base.c:861:42: got restricted __le16 Event
   drivers/scsi/mpt3sas/mpt3sas_base.c:862:49: sparse: incorrect type in assignment (different base types) @@ expected unsigned int EventContext @@ got ed int EventContext @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:862:49: expected unsigned int EventContext
   drivers/scsi/mpt3sas/mpt3sas_base.c:862:49: got restricted __le32 EventContext
   drivers/scsi/mpt3sas/mpt3sas_base.c:1102:64: sparse: incorrect type in argument 2 (different address spaces) @@ expected void volatile @@ got oid volatile @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1102:64: expected void volatile
   drivers/scsi/mpt3sas/mpt3sas_base.c:1102:64: got unsigned long long
   drivers/scsi/mpt3sas/mpt3sas_base.c:1151:52: sparse: incorrect type in argument 2 (different address spaces) @@ expected void volatile @@ got oid volatile @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:1151:52: expected void volatile
   drivers/scsi/mpt3sas/mpt3sas_base.c:1151:52: got unsigned long long
   drivers/scsi/mpt3sas/mpt3sas_base.c:2680:32: sparse: cast removes address space of expression
>> drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got nsigned long long val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: expected unsigned long long val
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: got restricted __le64 <noident>
>> drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got nsigned long long val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: expected unsigned long long val
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: got restricted __le64 <noident>
>> drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got nsigned long long val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: expected unsigned long long val
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: got restricted __le64 <noident>
>> drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got nsigned long long val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: expected unsigned long long val
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: got restricted __le64 <noident>
>> drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got nsigned long long val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: expected unsigned long long val
   drivers/scsi/mpt3sas/mpt3sas_base.c:2975:16: got restricted __le64 <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:3130:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3130:16: expected unsigned int val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3130:16: got restricted __le32 <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:3152:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3152:16: expected unsigned int val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3152:16: got restricted __le32 <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:3175:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3175:16: expected unsigned int val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3175:16: got restricted __le32 <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:3196:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3196:16: expected unsigned int val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3196:16: got restricted __le32 <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:3217:16: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:3217:16: expected unsigned int val
   drivers/scsi/mpt3sas/mpt3sas_base.c:3217:16: got restricted __le32 <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:4651:24: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got restrunsigned int val @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:4651:24: expected unsigned int val
   drivers/scsi/mpt3sas/mpt3sas_base.c:4651:24: got restricted __le32 <noident>
   drivers/scsi/mpt3sas/mpt3sas_base.c:4672:20: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:4681:20: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:4695:36: sparse: cast to restricted __le16
   drivers/scsi/mpt3sas/mpt3sas_base.c:5864:55: sparse: incorrect type in argument 2 (different address spaces) @@ expected void volatile @@ got oid volatile @@
   drivers/scsi/mpt3sas/mpt3sas_base.c:5864:55: expected void volatile
   drivers/scsi/mpt3sas/mpt3sas_base.c:5864:55: got unsigned long long

vim +1690 drivers/infiniband/hw/hns/hns_roce_hw_v1.c

a680f2f3 Wei Hu(Xavier   2017-08-30  1662) 
281d0ccf Colin Ian King  2017-09-29  1663  static int hns_roce_v1_post_mbox(struct hns_roce_dev *hr_dev, u64 in_param,
a680f2f3 Wei Hu(Xavier   2017-08-30  1664) 				 u64 out_param, u32 in_modifier, u8 op_modifier,
a680f2f3 Wei Hu(Xavier   2017-08-30  1665) 				 u16 op, u16 token, int event)
a680f2f3 Wei Hu(Xavier   2017-08-30  1666) {
cc4ed08b Bart Van Assche 2017-10-11  1667  	u32 __iomem *hcr = (u32 __iomem *)(hr_dev->reg_base + ROCEE_MB1_REG);
a680f2f3 Wei Hu(Xavier   2017-08-30  1668) 	unsigned long end;
a680f2f3 Wei Hu(Xavier   2017-08-30  1669) 	u32 val = 0;
a680f2f3 Wei Hu(Xavier   2017-08-30  1670) 
a680f2f3 Wei Hu(Xavier   2017-08-30  1671) 	end = msecs_to_jiffies(GO_BIT_TIMEOUT_MSECS) + jiffies;
a680f2f3 Wei Hu(Xavier   2017-08-30  1672) 	while (hns_roce_v1_cmd_pending(hr_dev)) {
a680f2f3 Wei Hu(Xavier   2017-08-30  1673) 		if (time_after(jiffies, end)) {
a680f2f3 Wei Hu(Xavier   2017-08-30  1674) 			dev_err(hr_dev->dev, "jiffies=%d end=%d\n",
a680f2f3 Wei Hu(Xavier   2017-08-30  1675) 				(int)jiffies, (int)end);
a680f2f3 Wei Hu(Xavier   2017-08-30  1676) 			return -EAGAIN;
a680f2f3 Wei Hu(Xavier   2017-08-30  1677) 		}
a680f2f3 Wei Hu(Xavier   2017-08-30  1678) 		cond_resched();
a680f2f3 Wei Hu(Xavier   2017-08-30  1679) 	}
a680f2f3 Wei Hu(Xavier   2017-08-30  1680) 
a680f2f3 Wei Hu(Xavier   2017-08-30  1681) 	roce_set_field(val, ROCEE_MB6_ROCEE_MB_CMD_M, ROCEE_MB6_ROCEE_MB_CMD_S,
a680f2f3 Wei Hu(Xavier   2017-08-30  1682) 		       op);
a680f2f3 Wei Hu(Xavier   2017-08-30  1683) 	roce_set_field(val, ROCEE_MB6_ROCEE_MB_CMD_MDF_M,
a680f2f3 Wei Hu(Xavier   2017-08-30  1684) 		       ROCEE_MB6_ROCEE_MB_CMD_MDF_S, op_modifier);
a680f2f3 Wei Hu(Xavier   2017-08-30  1685) 	roce_set_bit(val, ROCEE_MB6_ROCEE_MB_EVENT_S, event);
a680f2f3 Wei Hu(Xavier   2017-08-30 @1686) 	roce_set_bit(val, ROCEE_MB6_ROCEE_MB_HW_RUN_S, 1);
a680f2f3 Wei Hu(Xavier   2017-08-30  1687) 	roce_set_field(val, ROCEE_MB6_ROCEE_MB_TOKEN_M,
a680f2f3 Wei Hu(Xavier   2017-08-30  1688) 		       ROCEE_MB6_ROCEE_MB_TOKEN_S, token);
a680f2f3 Wei Hu(Xavier   2017-08-30  1689) 
a680f2f3 Wei Hu(Xavier   2017-08-30 @1690) 	__raw_writeq(cpu_to_le64(in_param), hcr + 0);
a680f2f3 Wei Hu(Xavier   2017-08-30  1691) 	__raw_writeq(cpu_to_le64(out_param), hcr + 2);
a680f2f3 Wei Hu(Xavier   2017-08-30  1692) 	__raw_writel(cpu_to_le32(in_modifier), hcr + 4);
a680f2f3 Wei Hu(Xavier   2017-08-30  1693) 	/* Memory barrier */
a680f2f3 Wei Hu(Xavier   2017-08-30  1694) 	wmb();
a680f2f3 Wei Hu(Xavier   2017-08-30  1695) 
a680f2f3 Wei Hu(Xavier   2017-08-30  1696) 	__raw_writel(cpu_to_le32(val), hcr + 5);
a680f2f3 Wei Hu(Xavier   2017-08-30  1697) 
a680f2f3 Wei Hu(Xavier   2017-08-30  1698) 	mmiowb();
a680f2f3 Wei Hu(Xavier   2017-08-30  1699) 
a680f2f3 Wei Hu(Xavier   2017-08-30  1700) 	return 0;
a680f2f3 Wei Hu(Xavier   2017-08-30  1701) }
a680f2f3 Wei Hu(Xavier   2017-08-30  1702) 

:::::: The code at line 1690 was first introduced by commit
:::::: a680f2f376fe70bad85f350059be995c9dc2a802 RDMA/hns: Add mailbox's implementation for hip08 RoCE driver

:::::: TO: Wei Hu(Xavier) <xavier.huwei@huawei.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
