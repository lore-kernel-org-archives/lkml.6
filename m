Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCTXR6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 19:17:58 -0400
Received: from mail-ve1eur01on0063.outbound.protection.outlook.com ([104.47.1.63]:21883
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751578AbeCTXR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 19:17:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Tue, 20 Mar 2018 17:17:47 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180320231747.GA9216@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: LO2P265CA0117.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::33) To AM6PR05MB4456.eurprd05.prod.outlook.com
 (2603:10a6:209:43::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5b58e1e-1016-4ec1-9e0f-08d58eb8ce8e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4456;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;3:8tLNlq9G8Vnd0N+9rjLwMYnyF2hWNFpMxV7NkPPveYxSW88JhUhDHwdU1Fwbl9nMTCO1muykkgd3cHDE6g4K7CUBjmc7/JhSGFHYEqhIB/Iv9ioU0IRJgDO1rQIIbrjDOFmZqsLbEIW/p86KRfE4SKtpp5b9J2X6Lh6G10Fbl4W0Oq7K2D0JN1GKiOUD3kfw+kx10X6PcFMwtyrJ310XQvBFMuEwm9wWx4E7WorMsvM2UIh0MLt1N7R8H+dsZkDv;25:pm1YMKgTPhVjXHwbX46RH/PTi8NJcTuxbX6YsOoS3z8z7BAKbQe778lOqos21tKqIAQhyM6w7Q/lnnZBJ+pflg8wBWu91tXuFQukuubLOWQ3DFrbFVJ9V3Je613BAJOG4IpJidI1B8pUf4/qu1WJsBYYjLff1Lt5Q90onEeezaVXsqqcZkutJaT0wpLCTT9Lvm9kOWgBKJdcM0lZ67s3+Sos5+01aFImRURHInaWcMNNsQ6kwORRb0cU56c++/594ENC18yDyme95fH6GVpyjM0Zsi3liTQ21zQ58y81yFIxG5xv89j/Lzn8o1NGaF6J+ppxQeDDQEt74a5loDhfew==;31:Qt2Lq7zHuCPs9Hs69JzO4HtJSe5lBMK+nYFJcDo8ejjQmnDJhfWvAwo04ggZt6Bz1AKuirS5EbLgjZGs7D129K0RraXyFoeuYV9DSX/sZgVdy5a73n7zLMGal4luOwXKyI2/YNgBdnLarPZB84WWX3Ea3tl+vUV7gsCTx3Pnf+3Xz0Jgtaaas2mmntdyXbTBUApnRSZ1SBD5AMEXSFeRMAHbInSPLvrcrKv0venXH7o=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4456:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;20:+XUGeZoeaXFHkR8fNHXnqVpECaMohjnrDzKW6Hpl3JLyc+me0sKmYwaWwD7dUVAC0TEBYh6Zd4IUy+bS6vVoaV7MjP8A47IVDa771yw1AdQxy0ibQU8Xqbu8nXwCy1nKYUZDfqtNCi9SrrVXkH5VH/vwTO5/DubHlmZ/1LIUkw6t6MPMP/kncMhv6oQBvfsjM1cUVWKEQgTqG8G4653DtkF8utpu+UWrXKbTeuPjEdYoKupMAUwbudeWZlBDQvv19lIdaRVvziTq0RVQFfesWjBTpyJdQmqqeYasKAi7AnojvxSJTS047b/zMXDI2MIsoD71ZsiO3JN9iJEDh2m6xoHmIVyj/dedbobFkL0eMS1/z4j7D5G+ChcGvdptFK/hjPfoY0u925V6MLx3mNBaRuhGe5sKcYfoeawbxdyUccL8rEofZJRT9QWTnP/j8rDUDHDBNs0cQPwhXPQf9wUoIgV8k2KOJBf6qAKYqqJ3akL91My5FPssgdCoVCKHq/iq;4:wUDy1AGjZXdf/PWvJ20Ko7ErdWrjBo+mQSuM7h58JSBNc9e16QYtKrnvFPe9hkxMK+f2b5cFtDR/LiqGoYKjBvWs/x4GBj5sp+6dgQWJc4ZnPaNXwMfIGjR6seq8mOtSY7YQ0dx9nISmj7o62A1bixvMzYb8jizArsZ75W93POpCtnd8MnmxEgo0MOWyrLAp3pOlnAxFqSevNmvgWTkJIzwXKIyLDW7zpsIr3IWfPWxrozEXCeBVJ1yRaIWRfbUTrsgP4hV0NMp7MbtyQPDHd2ViApRnsIlC3owbIqiAxfK8XuJCg4CsWmndHqmfRVNR
X-Microsoft-Antispam-PRVS: <AM6PR05MB4456352FD0E7BE7B61E121B9CFAB0@AM6PR05MB4456.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501316)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM6PR05MB4456;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4456;
X-Forefront-PRVS: 061725F016
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(346002)(39860400002)(366004)(396003)(377424004)(199004)(189003)(9686003)(81166006)(8936002)(9786002)(9746002)(122856001)(5660300001)(81156014)(86362001)(21480400003)(63394003)(44144004)(33896004)(8676002)(3846002)(1076002)(66066001)(46656002)(6116002)(105586002)(53936002)(478600001)(52116002)(2906002)(97736004)(16586007)(7736002)(58126008)(33656002)(84326002)(57986006)(83796002)(110136005)(36756003)(59450400001)(305945005)(316002)(386003)(4326008)(26005)(68736007)(186003)(106356001)(69596002)(18370500001)(24400500001)(42262002)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4456;H:mlx.ziepe.ca;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4456;23:hYcvXHX8MchM7KfeOT8u2ICxnv2czwSVx9M06TGyu?=
 =?us-ascii?Q?FZlShc4kP+WQEXxlyPkX7JpfRRQArkp2tjtn9/Q7LkwIXqKTlwWG+29grBCw?=
 =?us-ascii?Q?/c0vvTu4XbSAqvBPzq6kZ2ES66omFuP3hKzSYSbE5WM2BJgaAHLYrMrkIk/h?=
 =?us-ascii?Q?ZM2wTMBGz7PqDcbYn9ILcpRCqrZK8yC5Xk775vSvmcpHuOSQzi/9BwZEQNsi?=
 =?us-ascii?Q?5OiH7z7vRY0sdslnKYdCubFgm4v+LpfGeWYwev4QG6PbyJUoZhwvBqbCfUCI?=
 =?us-ascii?Q?cBK2A3L3EqvdH0pRCJkwyRIvk6SrLs/z/6Cwkqkt8rkNZJBHZV2qhPiJ9gmC?=
 =?us-ascii?Q?HTS8gS1468y4oCgy5Tdj48LdR2pkxNXTt3QQ4Rpoz9Ovy2M10DjSl64Z5VW6?=
 =?us-ascii?Q?wO8YSOVkjWs2Fsy37y+6wIXbF3rDHrko4cTGgoq1iItRMkpXlnkr8lEnzp8u?=
 =?us-ascii?Q?EcIETSADTOZkpk9sEXaS2WF4xsdG25QFDXNqIHKYh4axfaedvaHlLpD8aQZg?=
 =?us-ascii?Q?NAelr4bJdA5TJw0Etqb/wcRRnEqO1vO/725xLy1ciE2f2ctl9Bvz66G3cJrv?=
 =?us-ascii?Q?BGGTJtIvHVKj3FINB8zrBYQ47aJGXtq4pTz/0Pnxs7PhZwfxRrjOwEQZw//O?=
 =?us-ascii?Q?kf/xEe0gUXOvvEJs+4nlO6LkR1rijy7m2twvQntO5AFtmrgsL3hhoGT73GMi?=
 =?us-ascii?Q?DYfWxn6cIgRTG2JleFFsZjl6OGp6zL6jb/lfcJ+YUkYe8EyNpvcQamR9gede?=
 =?us-ascii?Q?BPqOJcCrJ3WfR++7gq5vBJ55viVOTzVnHqm6XZI4GNVcUl6kDDaUKyeCpEiH?=
 =?us-ascii?Q?PtFoeKHQgS4T+EBJsk1hITcfqy7O+39U4D6eeTH1csAMnMyvQJ3Ovg+6YRph?=
 =?us-ascii?Q?QDKoFVh+AtVnNNqyANKXd0rxfP55ebR/VVOUkipRrv6Up6swzvHsNfKlkjtj?=
 =?us-ascii?Q?QiQZ+MG94Gn7qrUyB/TaEa8wjWUusUJ4rHl4aY2UqKLdyZFaresURAdkA59/?=
 =?us-ascii?Q?MieZ6DMAAYZmi1F1y+okjrKBptmBnssAWGxYfd+mMF+80C4imvOpytiBmQ4e?=
 =?us-ascii?Q?ziyQ8ikGQqdwCAirnPoPs9denO5aJ/Ud4JxgEdw18phea+7QUbQeElW3OGC6?=
 =?us-ascii?Q?Cm76wrV5k9bGEd6abn2uPo22r/XVaA+cU8pFSntXy+HTvE0BrFMylxxX90KH?=
 =?us-ascii?Q?gggB1M11WCIUmrfnY+DOmhNnYPzVhCK5R3F1t0WQ3JGCpjzM1n4mpMsYXYOY?=
 =?us-ascii?Q?Ts5cLrhGd0qVi3/epcGEtfyNTaunHb7zFSsgiZaJu55iBrO3maf8CLPKybid?=
 =?us-ascii?Q?cUevUoWoWsBnYFVkvT/uZEyHfr5vpvzjDMdsuRwNg89?=
X-Microsoft-Antispam-Message-Info: iOdriTSdgRjhmCyJ9wxTO5QzWqdQdUJDDv7WQaa0Aei1iCx+hR9mF8yGOktQnlZbbtwOon2p1T8btOFKsKA85cT7UApcSqroEXGPRiMkYjzFRC4wvvFuYL4+jbE5s56CAx8b0OwNi1Lunw3PGEJWRIADv++PYn+g+Olg/54ABE6BM6TUhLC8B2QsJKcdAwD8
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;6:v7OvKSibKthyPJ7j9B/IZPIr0KpyLDlK7T3stkngOA3xe2WO44aeKCfngoYpJbSO9M0onRPg4Asrt+kPbr/LLiHtbG/w6+9mqzwQDC/B75c6nxxYlI7K+KgNRGq4uojpiiYn3u4D/qQ447xi7W1JkaHOqEj1iltsIdHZXVwroYs598v690KYyA3AlV+DS2Qc/h1kqyAqFU5fFkenUbI3IghGE1B1VIPIKCYmL9cowZ+nQ/+ZmVoPV8Q549jaovMdFQCF/T3aqM50tmNZCeU+f8jUFvfFk4VzabOrneK6IL3jyEi69lHy8xaHjjNMxMs6gHGi0NUhwz0USAxHqCKvm9g2qcp3mX85WYffebek7nA=;5:qqmoYzIarP2DLeHT4R476wjhI0oeU+UuwY89B4sfxywD+XZ1pAnYEE7K0dZYnxI0adO+xnFKhvucfyrgZmiHUemyrRjXBkkF8RMxgXxmNg5J7DAWEKHRMSqVsBbtllCrOZ/c70jI9AeCqQ7p1lpx/2og9644pHEQaspTP72YADU=;24:uPxS9LTgR5DSHGQrAEHHLY3/xxLi0cHQ5bhKDOlwoo6ddLVqo05VPv260zdtzwPfJU1wD5wsLF5XPfdCrdL1uPNq/ocqIrT5kdqZU3tUYTc=;7:Hl8Bo01eOVEJfNeoAXXbmRisnfVF2wVRqEikOaTQgnwmc9f890cADJwKYUWbHXZPbcCrR1rwZbx4Yulv4nIMfRjG02JjwqooAeEGCiIBKh8LEDkPwtHEAL1qRa8PmvuWsFTsCNXqfyoAeqmoZP3vUKWw5HXhwKcweJaHDhG1+DlCRQBEQsynW8qVYiWamhnpZBq4dhdQRg+MdW4m6KDYV1LccrSdWPqNnfI2a13gTNaGg0CoXRpjUkPv4UZjg6Ch
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2018 23:17:52.7435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b58e1e-1016-4ec1-9e0f-08d58eb8ce8e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4456
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Fourth pull request for -rc.

Not much exciting here, almost entirely syzkaller fixes. This is going to
be on ongoing theme for some time, I think. Both Google and Mellanox are now
running syzkaller on different parts of the user API.

The following changes since commit 28e9091e3119933c38933cb8fc48d5618eb784c8:

  RDMA/mlx5: Fix integer overflow while resizing CQ (2018-03-09 18:10:48 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to e8980d67d6017c8eee8f9c35f782c4bd68e004c9:

  RDMA/ucma: Ensure that CM_ID exists prior to access it (2018-03-20 11:07:21 -0600)

----------------------------------------------------------------
Fourth pull request for 4.16-rc

- Many bug fixes related to syzkaller from Leon Romanovsky.
  These are still for the mlx driver and ucma interface.
- Fix a situation with port reuse for iWarp, discovered during scale-up
  testing
- Bug fixes for the profile and restrack patches accepted during this merge
  window
- Compile warning cleanups from Arnd, this is apparently the last warning
  to make 32 bit builds quite.

----------------------------------------------------------------
Arnd Bergmann (2):
      infiniband: qplib_fp: fix pointer cast
      infiniband: bnxt_re: use BIT_ULL() for 64-bit bit masks

Boris Pismenny (2):
      IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq
      IB/mlx5: Fix integer overflows in mlx5_ib_create_srq

Leon Romanovsky (7):
      RDMA/mlx5: Fix crash while accessing garbage pointer and freed memory
      RDMA/ucma: Fix access to non-initialized CM_ID object
      RDMA/ucma: Don't allow join attempts for unsupported AF family
      RDMA/ucma: Check AF family prior resolving address
      RDMA/ucma: Fix use-after-free access in ucma_close
      RDMA/verbs: Remove restrack entry from XRCD structure
      RDMA/ucma: Ensure that CM_ID exists prior to access it

Mark Bloch (1):
      IB/mlx5: Fix cleanup order on unload

Tatyana Nikolova (1):
      RDMA/core: Do not use invalid destination in determining port reuse

 drivers/infiniband/core/cma.c            | 15 ++++++++-----
 drivers/infiniband/core/ucma.c           | 36 +++++++++++++++++++++++---------
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  4 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |  4 ++--
 drivers/infiniband/hw/mlx5/main.c        | 21 +++++++++++--------
 drivers/infiniband/hw/mlx5/mlx5_ib.h     |  3 ++-
 drivers/infiniband/hw/mlx5/mr.c          | 12 +++++++----
 drivers/infiniband/hw/mlx5/qp.c          | 23 +++++++++++++-------
 drivers/infiniband/hw/mlx5/srq.c         | 15 +++++++------
 include/linux/mlx5/driver.h              |  4 ++--
 include/rdma/ib_verbs.h                  |  4 ----
 12 files changed, 90 insertions(+), 53 deletions(-)

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJasZaYAAoJEDht9xV+IJsaJn8P/RFgTjGlR71ysQ7h3QrGbf84
7LIq3vN1RGXN3H586OPqc3hMYbIfxIV2qTiusXP9DTGREdyl2c/MSzM42t3VlNKj
UFMM2tqYr73aAHwnPlRENRPddNI9Ju7ring+IZNKh9foVcHrXf604UNyVU8kEEak
SHxM0jj8nfvrtvtMJmOSV9VKu2rME/zbpfFa9Ch63Ze9+wO5ogyfsrKasIhNfLhQ
vaucDgvdt+BqQvI3ka/TrUp03rOw1hAfmKxtC4tIeQosseC6levCSWCiP2xnoFHI
GAXtEPidL/dP/dzmZdhBObEFS7JODuuh5sG3sBze5QcrClPUHMjMrlpH/1rxt4Gi
MksXqN6cObke6z5y6MOZ1ygLFskdOR/L6T2rBuZD7A1bS+AqQrxu4PMANR+U8scy
a7MsnBSiXm20m+UT+bYKdU2WLjW0S97sFQl2FKVTPgzn8SwVixeyqoZRaSifnYht
5jhiiV5ebmAeGbOMGS0IhemtHTkYk0ldZ7NuyBOmlLTW8yoq6//fEp8AVZ/HDCu+
20fpWC8f+l3Ln+coTtFoMswVRn9HqxIlSKCG210CIvNj5iM9mJ4k//I2hs+q5KGo
HWX7oryFLlRhFUtsRUhhuKdlnVzH8S82qZGHK0F4sZIX/k9FgneS32avwPGBVyWm
B5FXQ0aeKSJfxAjJx0EX
=EQhT
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
