Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeFAQrp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:47:45 -0400
Received: from mail-eopbgr00075.outbound.protection.outlook.com ([40.107.0.75]:35552
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752934AbeFAQrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:47:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Fri, 1 Jun 2018 10:47:32 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180601164732.GA21374@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4f::29) To AM0PR05MB4449.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4449;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;3:WOVQKIK2GqRm2Jh5H2RddwNFBbTIARPRawh6jW+zbkrL8kHU/JD/fQeLRxAVFwsry0fWtAozupsb9+SV+Pg38/uVeywmHopJ+s2K1AhgB15h4Nbr54MtckMgR8ujt0UQDI/aJ9lQnJuaqcojFUnCfdRjo0YOcMMlcqRVtcRfSDfc6Apg+cA76k3kn9nDOkqw2gZyBuiAIrlcErq/Ca80H++OJNqqzKk0L90el3lVK5dNhX1c5eWDzqwaWUrasYzh;25:kh3EbKfKIikG6tLL3n20t69WSHv1SZW6ohjhubKVp3AZAfzWVUWdvaqJl4EzLkE4OFU2AQ0KbpQJLAn9pJmHhmFQnY69i7lw5FlhCUK3amLMF4rT6DxfjTsXDxl8DWPIH+fKYZ6cF0/byVCD4nAJKRDeZcLE8zjtoFCPUBXFASiTJgZ4ra+sodIhyfHdISUDu3D7KzilI96qEEM/DO8+N+FjM2NO+of69wgOwZ0fyN4ao+1+PsfJVppF4aAK3zqecI++hGvY3JXbO8titaFNo6BLUIYFNX2Iazp9PGi3glrmEUeDtvebUHML7zF7cCWbqOYV7BAuxLgzNqg2YrwmOw==;31:+QFP0VNFs8K0U7+DF3pfFiwaWx2CJ4xorVPGcAHKh5AwNpyxf2R/6JxWGUqgsdzZxKHbpbYr8Ukjq4ROqLvV4Ng5T6BYt7oBTj+8d+kU/SUHwnk/OF1LEeLrfz7l30VAkyNDq+Hj7eR8isp4jt4IKBEOdoxbJiknjVe235+8RZwpEzxNNFCT7hvF9NuqIaikJUAM+IaLgnvm3MvLKQFuA4ehuRHna2hS1M1Z4yxDAhg=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4449:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;20:X2Xcf8oWNI16dC41kAK+QgGRbH5D0uf2OeWKuPSE1aBSt+TFfKMWh+IMeY8vfHbZSnAnKYwmPFDf0S2zC+CAVWXDkyHsspHvD7F9u90+lZVGgrJXd8mmh/kssMePmAPZmm+ZCa4+KgrMfcn6A8mgLIMVu502P5NOYTTpCh2fuji75drXQ0WDibksL0zXq+SPm3vQaawoDGNo1trnzxUwPiTYQeL2Y7IMPFFsmSmknL9fqTZ5DqIfOeJLaUhpNY1blyemF4qPCIbQrGWbaV9tyFS4fZyXSAM+Bs2GyFoDbwX2J6LLS2hbUmPFHtqTOFsm1b4ncd3sDWzmsASYJkm89/98xeDh7BxGNL5uNPJ72jUJPZhyMQHBpIVCInyHYrM1yOcvJ9uW8vMMd9/pBgF8DZSpixx/itO+r1LdZOnIQDyzKVnKRVtPvCDvUCjksAng9g4f3Q1qrJ/TbFOW7EFwYxFXElYbdhyCJa/o6qD5PwP7lIwf+AfUVFH3DMI25RnA;4:m2UmXOzSlMclZSHcP05rgBG57LCK3/mLewMlmB9tMfG86BxxSst8IoCEgs3HTdLRpwPEgBIr2COeUc4uN5E3H2A8Wt0u5rbbevh14CA6cl0/tYCNeVsRooAUEgHRZB59me1xWtSbJAS90fge4C0E5W3y8Amj59b5Keb2PTOv8/eVMvWz7yeGvAbo/JE/ErvQzrkq3s5YxzC3f2nVo6mpPYO6tc35l3EG9LvjJMWUXQKVLHy+ZTVBIxMPCaEFl9A7LF8bEsOaBbxZHMn/6N8s6++olgwyZQtfWTzy2IwZEEg+XCholi90yBCm4U8BSn3Z
X-Microsoft-Antispam-PRVS: <AM0PR05MB4449EA3FA0D79C3090EBEB3CCF620@AM0PR05MB4449.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR05MB4449;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4449;
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(476003)(84326002)(386003)(21480400003)(59450400001)(5660300001)(186003)(122856001)(26005)(9686003)(69596002)(1076002)(3846002)(6116002)(33896004)(53936002)(16586007)(110136005)(106356001)(83796002)(105586002)(63394003)(81156014)(4326008)(58126008)(478600001)(46656002)(2906002)(66066001)(316002)(7736002)(305945005)(8676002)(9786002)(9746002)(36756003)(86362001)(81166006)(68736007)(44144004)(52116002)(486006)(8936002)(97736004)(57986006)(33656002)(18370500001)(24400500001)(42262002)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4449;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4449;23:2UR0vRvaMSr+xznWTMLs+KSwvJnnamUxdP63o1D8t?=
 =?us-ascii?Q?9yra3LKXlYzDpsUv/Xu1FqG1TXoXs/tw71B+ZRm54jKA0JK/5sA4uGP0EzBz?=
 =?us-ascii?Q?F41VFObNNUaxb6088nuMH/piwqcpgNnl3RidXKhBDdHYL3w0I9EE/qutBQ8o?=
 =?us-ascii?Q?k04MrwyyFU6bALNa7JM3fAI+eJWNyIaIWgj0cUtGSL29AKGxvbMeHL4yiw5S?=
 =?us-ascii?Q?FUqiFqJK8dAOmaly4iipK/eatxCb6CfzoKG4La3uoYVcporXBwj5PMtQKJOl?=
 =?us-ascii?Q?hnX8XaHl9L/vXv6muuVaNoKxD3PzeF/V5ec6mJYQwzyPcDeRgUbAKFi1uk35?=
 =?us-ascii?Q?DgWqWLlzoLa9tPhgie4R6cGqdCh4L6Vk+e1gmz60IYzDwUUH4hz316o/HL1W?=
 =?us-ascii?Q?jq20jZaLlSjcPan3xw3jeRYfSbBZr2kpGgMKxdCD1ZjYFHJKtEzbgGQuSAVp?=
 =?us-ascii?Q?QrsTQSnbkyJllh2Ync7XHnnODvoy60+xHBt7dHTQcGBlmw3sNNAU5CKzSGDK?=
 =?us-ascii?Q?aI4unLm13p4dC36pAucxB5dt98x848PQjyClecfMGqg+++EqTR4UgVqdsNtq?=
 =?us-ascii?Q?rbcSXsBpViwKfsj74tzz4ILXlVBrt0YUO+tf3frbri8x55BiJCr87pvyt9Zo?=
 =?us-ascii?Q?5IZ5e+LptGmlZnLuYzO1Op+bpkALQFmeFBq8MW/Xv4i+2Nj46XTaARnyYeYh?=
 =?us-ascii?Q?msOCiiKPn8gWINNvFxgsjD4K26HeBVap9AQyVzFruRRJ3WRtAsbbxZomdRe1?=
 =?us-ascii?Q?SzCwslrVwX2N0KGppRxTZkpoc2pKyzjeKNb2gQ7yo5B1ccbyy6l3lHDhNQlu?=
 =?us-ascii?Q?+OpEBrgGxnlXFCLMhl3Y21v7OG6G0I1gUOeleOja2AX0KrHQZDfCODkFrEC9?=
 =?us-ascii?Q?RtloY+txfbfRZL6MLwXR0XmvRGKXHtqbVpsdOFCdENyizgykYgNlR7gVsuAu?=
 =?us-ascii?Q?u2KxcKfIQ8dmMS8lcNVdKainOL0HTk2dxUb+wlQCEobtnBLBOFNL1Yfd3/hb?=
 =?us-ascii?Q?f7Q1Z7Mk2tDkEubnkNnbFAN8qQiaA3V4D7Kwd8HO4L+b8qIOvWx0kywzDg68?=
 =?us-ascii?Q?NhAnTxAOKy7Y6tPMX2AsaZUWcBFxN3sQ6fetwvGNk1ruWiC0giFYsG5npPFx?=
 =?us-ascii?Q?7R7XBbW/MTUjS7N7hlighGufEXEwJRKbyVR4kgbdcPncXEXhWxb/r5a4tuvp?=
 =?us-ascii?Q?GWRPKNf94ji+trSuF3bk8U+Zo32o1SlLKsYHQfYgH2DDXpyPlo2yhNOfAD0l?=
 =?us-ascii?Q?5EwutESlN1oZ5VhWLP/HZM/uXXaKlTGQi3WbP334V+logIKjGQQMy/q4F6Rx?=
 =?us-ascii?Q?BiI7iL2EOVX+5/fx40A5Y8kKvq+ow/0MdGULjFLZXnZ?=
X-Microsoft-Antispam-Message-Info: kn2JaooFczL8riq4rdXM8wEdcAnp7sbVCCQRHwp+PCMc6GtzwoIrGFvvBjeheR42kbHEEu2SjEcYdU52nESHH+vqwxSLy+wpw5lUmBNtnxjk7w6y2QvZEUOmeRULfcZnU4AvTaNndfxhwscaqFddftfSWtLCPgHF5Cnmfu4qMqyCxKvdzct8f5UBd6mP5+XS
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;6:wxDfnALhFCPbMbXRrnYTM5tBIRTv+bBn/u91E+6+rOR82HgAOjdCP8Wt3rmeVyEOZFOmnJEMxW1sfoT5hnM7B/nfq6+6FbkuQdxU90YDsK5ZqdipqVk2EjqRJ7lKY8scEGu5+10Ajx8wUfZjSK1iBVBbJJt24KPaGfkaqyKtgbsWr5WOWKrJzEoeyQ8wTaXbkEb8kkWXOnjVcjXj3GXbGQZz5UVjqNvERmGbq35Ct/yjvS0vOzVt87nMdVj72V6C5kPviu6520tGd3upamBIcChsIesX459WXWeLPXzp+UOf3CBSKaBnDZ3oq7GRS/FKpFMIRihB5gPjSQDXAgP81j5oDhu0zIToTkBeqNGgNm0YIn5+Q9gEagiKNK+mEOfiV9fwmSrEQ7ImlLMv/0dZxuvgbaoZ9tKUqyDu5zoJS6zWL5slftre4KT7in9P4hJttRgUio/bRhdY8ivD6cP5Vg==;5:ZLdyNZxNTlBQ0xtMavgTepb2Ib4NktZ9DN4ixQI1cp+2ly0bC+vEAwE8U7zMpcSKU1pbKNVqs+52e6RABAg/PcoIhTc9LuTPxxflYkTkmPp8u+pSZ5XSRlqYnuhlYockL2PXAqycZbMqLnejZu12f3LDqEFvMyeIj5MZzI0JuHc=;24:QY7nps98SpdxJ7vObeHehOg1Qmv3EvbBLdfu7ERd0tMcricFzs5dpCR8hYwWuPCu8J2Pbm8UObYB7vsRsjVvNVNlYpL/wZv2MRklvtkLHsU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4449;7:t2JEpiHQYEPZGO3rg2+MEYFdUKsnAB6Bi7Mvve5sYZr0aeLtjBSUg5hPbYY+f8gsUEQnqUTVPBQm7IsaykzPSyaEU5tlRcZ0pveNyrbuUaS5pKxhzvv6W8y4bJJQH1jH+qgMNdsQ/Sxe1X4Wz3Hr0xpnBkUEoLVksW8wtSx9bumFPmBsvtnj2HOCVcwS4Yq6pFgTWWqRgkqvIuLo/DPYOimf5iFbmTyvJeb7svBXs4aLMRhNrezG/fXwTqMVGarP
X-MS-Office365-Filtering-Correlation-Id: c3d94fea-3cf6-44aa-c4f5-08d5c7df62a4
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 16:47:38.7711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d94fea-3cf6-44aa-c4f5-08d5c7df62a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4449
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Third pull request for -rc

Just 3 small last minute regressions that were found in the last week. The
Broadcom fix is a bit big for rc7, but since it is fixing driver crash
regressions that were merged via netdev into rc1, I am sending it.

The following changes since commit 55ba49cbcef37053d973f9a45bc58818c333fe13:

  RDMA/hns: Move the location for initializing tmp_len (2018-05-23 15:45:44 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to a840c93ca7582bb6c88df2345a33f979b7a67874:

  IB/core: Fix error code for invalid GID entry (2018-05-29 12:08:37 -0600)

----------------------------------------------------------------
Merge candidates for 4.17-rc

- bnxt netdev changes merged this cycle caused the bnxt RDMA driver to crash under
  certain situations
- Arnd found (several, unfortunately) kconfig problems with the patches adding
  INFINIBAND_ADDR_TRANS. Reverting this last part, will fix it more fully
  outside -rc.
- Subtle change in error code for a uapi function caused breakage in userspace.
  This was bug was subtly introduced cycle

----------------------------------------------------------------
Arnd Bergmann (1):
      IB: Revert "remove redundant INFINIBAND kconfig dependencies"

Devesh Sharma (1):
      RDMA/bnxt_re: Fix broken RoCE driver due to recent L2 driver changes

Parav Pandit (1):
      IB/core: Fix error code for invalid GID entry

 drivers/infiniband/core/cache.c            |  2 +-
 drivers/infiniband/hw/bnxt_re/main.c       | 55 ++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 94 +++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  3 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 61 +++++++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  3 +
 drivers/infiniband/ulp/srpt/Kconfig        |  2 +-
 drivers/nvme/host/Kconfig                  |  2 +-
 drivers/nvme/target/Kconfig                |  2 +-
 drivers/staging/lustre/lnet/Kconfig        |  2 +-
 fs/cifs/Kconfig                            |  2 +-
 net/9p/Kconfig                             |  2 +-
 net/rds/Kconfig                            |  2 +-
 net/sunrpc/Kconfig                         |  2 +-
 14 files changed, 172 insertions(+), 62 deletions(-)

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJbEXihAAoJEDht9xV+IJsa2qYP/3GB77ZPYc+joHaEjvFD8AOd
BFr91XpB1lun32b3KfRs3j9MBNLeILhLMasWnVZeQXH95x4i5oG7cQ3ItVvk5DvO
bbrjDyUl1gj496IQ0ur0SvSqFkn9+/4/+eMBw1ov9oq3J0LNoPwOLR+SPsRfo3DH
51OtZiortaF7EkJEwyUCmz3rSP0Khwqx0MSWLmAd05t1Ca9Cbsa8NFJx/zNT9c44
Oy8YsH+eGeY+Kr2Hbv4eZhD1UC8TI6ixVt2zTpHTwnbqtQXuEU1OW2zrwbVlzqAp
/VS1ZA4VamDG6h5GOQtfFVEWL5z6VYQHU6WIOq8zNMYyIjqS7kPalV9/7XmDVS98
lZC8eCe8JF8sg33bI4mmYD0aisJmzzuuRx3xmxlHm1Wb7NbwBoRqg+sC9Z7ybPcw
W3lY++c550f7zXiS0XSR1ZirlvAYQt6b5JtRLfMWNsrt9k6gQWMtE726J1tVKO4D
Da7KbGBLhrH5dioLLAngKxgTelieNe67XhVBICY2KQl9SPdgSYVyMyfcRPN5foTe
f01Vs3kOD188EJ96AGfITBZ8jGPlFijrwtbe52qY4VlYSQG9NDgOBMeIuAEy5gcG
JEjjWU9umMlyg567vKfG5I98B8pc7vZealUnyqh1j128eZ4kud8dzPAY+tjP6vp5
KqHcdkVbcRSMdVQVUyci
=SfxG
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
