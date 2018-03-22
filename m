Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755450AbeCVNUn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:20:43 -0400
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:28923
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754477AbeCVNUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:20:40 -0400
Date: Thu, 22 Mar 2018 15:20:31 +0200
From: Leon Romanovsky <leonro@mellanox.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+3b4acab09b6463472d0a@syzkaller.appspotmail.com>,
        danielj@mellanox.com, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Berg <johannes.berg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        monis@mellanox.com, Paolo Abeni <pabeni@redhat.com>,
        parav@mellanox.com, roland@purestorage.com,
        syzkaller-bugs@googlegroups.com, yuval.shaia@oracle.com
Subject: Re: WARNING: ODEBUG bug in process_one_req
Message-ID: <20180322132031.GC19440@mtr-leonro.local>
References: <94eb2c0bc3aa8b2432056623c735@google.com>
 <20180322124823.GB19440@mtr-leonro.local>
 <CACT4Y+Ya8iMgV=7YGgsO2XnusF9tnGcHHPF5U5oNjQz_eJ+vMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7tuoKvP21MOB3sJS"
Content-Disposition: inline
In-Reply-To: <CACT4Y+Ya8iMgV=7YGgsO2XnusF9tnGcHHPF5U5oNjQz_eJ+vMw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: HE1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::11) To VI1PR0502MB3920.eurprd05.prod.outlook.com
 (2603:10a6:803:11::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb28a105-2671-463a-d4f9-08d58ff7b3ad
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3920;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3920;3:pzYM95tPl99tY0uT00Td5DSoWV77JuEd5vaVKAKMTtQgnB9adFpI90rtt+lEmqRGPbTmt9YeuE543ATaNTGGAeqjebAj5FOI1JsCZCtZPi7VX077CCZOPA8Pq+H7GLR3b2rY9t+8H9lpL0U/u8vq5TJVilCN7JPJUb96oUe5V8LOhgcSEqkODpjbdxUCIh8SbspG5fhJ4lRfFVpetdxgfXX/JJwVeSwcbWnIfgh449/ofT1zmHEYLLoDoxe6xvx1;25:zK8z8jOe+iZko2arO8X6hlUvF4Fmkj3fE12dvvvjuFZ18N6Z3K0ViJK2W37CqgAHGkRZC22c8fnm1vssaURs36JBDOh8qhzZPqrX7DJz28C4PdiVBHYxFXL/bCN9usHSU32YbDYMCbU5drl84Mjr5shErk9CizMhEbGid8T4okZ57uvfAM8av5l1QM9oUCLFSKZ0fUkgS4JQFvGSjTfacmveHDKL6cs9gQL/gW9yk7ARcJS56e6knul7U3MqZvyQlO40GxqNX+t/YKDuVOSAnGZcg4ppbz0Ti2th4TTClSIdJlMQIvode05oTlMqtpalIxcibQGpfNRJyBpSf1K9xA==;31:HiIpx0oTrfs/EFx4hZ4DlQ3ezOi9+RKoKPAXm4RK6Y8wWY694BNDwKAoTJ2aDjz4kbboDiyygxevoAhvQaOP37AQ76jkXDaBlYQtIxLDh7yQRJAUYARkKN/Ab8fkugsJifabUH9k8VtaChEuyw/CJ536kcP/ycRLUNLGQq8OEHhTbxegHcO0sl2ntd75G5G4ph3VhgAjlI++p96hf/E4BT3jYEbY0e/UiJhPe22x8Uk=
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3920:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3920;20:3fQkm/y+u+mRLeuHfaYw8G1EQ9LGAf13rCmPr37ByyFVyD/HW3+Y79f7Zl/pNsPV2SEFvXhstlmgmdFIJP8P/WqgND04RAaUL926SdHMhAJkp03dMrs+/gEZ0X2XuhW/r8LL39SwLAFFExAOS+rEOCz7wj2U99VPWvSwvbQ9J95U0yPFfmJoM2t9iW1WWd2uXD8M87Sacp/LWno0NyGDZFe6vtdl+2sLksAdI7Lh69AiqbVstyOwBkMoNbVdkH9Fe28pFrQL1xHBw/WnUdnUgq0f5i3vdSMzDXh3buxttpIaZozQIHIIzDFb0CitcdYA44usQjRCLZFJprJVNZuEvFBSzuGT0xS9Hhl2orjUzKQVJG/gBHiSQHKj9HGAS/CTEjwjvIpGewPzWTFMT2rt36Jbgmf5uNBRF7AhLcZi9fONK/Rso1CcPSu877EGqQ6dONnjSvkjXLZOzTAaUE/r+4vevqpDATOuUD55C9NhQmBPRU+U/pzQdr48owcT9Fac;4:mJ7YL/tKRNqkDZ9Rr+Fgtzxorn/N0N+r+D7ZD0GloDnQ+w9wDdZGeAZFCViQubadQ9bKzP2Ym+SfjdY1uPt73Z6fV/JeHFg8LrII/mBRFb21StTyoCWa35GI2QZz6lArCaMG+RyhsGLlU3f7mbJsjdRSZs0SnQF94Cq8U8HR+b2droDUYiH+Aca3f/aaqDGQxrwAMkRYG9l6MQgZJT0rOmx6+1jamLAiq1wiQedrKORR4HzBgI7ONwMDRTB6PN+Yo6eIrl7u3bmgCkpmI5lyNA==
X-Microsoft-Antispam-PRVS: <VI1PR0502MB39201FD79B0D75D79A0D6106B0A90@VI1PR0502MB3920.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0502MB3920;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3920;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(199004)(189003)(81156014)(81166006)(84326002)(8936002)(33896004)(44144004)(6496006)(186003)(5000100001)(86362001)(54906003)(16526019)(63394003)(53936002)(446003)(478600001)(76176011)(8676002)(9686003)(52116002)(305945005)(5660300001)(6246003)(6116002)(106356001)(3846002)(386003)(316002)(2950100002)(6916009)(6666003)(58126008)(105586002)(2906002)(7736002)(16586007)(7416002)(25786009)(66066001)(97736004)(6486002)(33656002)(76506005)(98436002)(1076002)(4326008)(21480400003)(229853002)(68736007)(26005)(18370500001)(2700100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3920;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0502MB3920;23:fbQ9xyn0LUSdSzva2SqLlXzeiWqldr9mslwhAyf?=
 =?us-ascii?Q?gQyKuZKTKUxWiVqGQxnIyhW+92IkCyJynfeN6N1ida0rwBu0i3CCUqL+3ZZZ?=
 =?us-ascii?Q?eMm++/c+XSjvEMoTuT93PRHJitbomXw02Es/I/+sa2hvh8MA0YnaP/Krr0L9?=
 =?us-ascii?Q?y9TbinN/yPMeh+HBQZ+c3cixZ98clfm45+t5s2iwGENWcm0rt9jk/JFNXDhf?=
 =?us-ascii?Q?dRn3yKlCssa/OYqzY4Z+V6iQQRH5GCCGmpLo9UxCxUWd8pdHaHahnWGBDK2k?=
 =?us-ascii?Q?r3HRmHZjpCsxPK7LgLjpcmzUcFLgKEy7yxvt+aKdZrvHyQ+MfY9D5d8NXWT2?=
 =?us-ascii?Q?fGGZCgFQUfkCSnQHqcEMbwJJZwRvZOFHjBBmchmC+isAou5+sl0svcJDkPwT?=
 =?us-ascii?Q?PviaAQrszwtvmOtINTvd0X2N+AUXl0fdMM9ZsLoAFxvpwO5/S/w8TOqt2p9a?=
 =?us-ascii?Q?Z/AX1hKcqawzDXeDr/u76lzHkG5n33MWrEJS6JmOxpwS5CAgw40Srsol3iBs?=
 =?us-ascii?Q?SeisH8aAssuA7oZDj8jbW/8qKVBnLLeltYuUDViscaW7zGttbG93RheM8fHK?=
 =?us-ascii?Q?LK0ZV3hmx3voHWDZbUtYXBaEFm7R2bN4enJRysA0RF+06PMkFwJtOedAuGP1?=
 =?us-ascii?Q?wQb0K+kPAB3f/sT6/+DS1J0BmbZb3phmeyMf0tQUADjJ6YN4GG5qeTOxGjJJ?=
 =?us-ascii?Q?hCOhH8+i/veMFsfym+IIPEW1dzqpH5Cuu9fzbt3FO0dWAMQxJaKu2g5rzZeT?=
 =?us-ascii?Q?Yoq5Hp3TKvtZSyz2TpA/+xmW78HJ6+VpbnbJX91snnHBnAjNgiuXExm7mNnJ?=
 =?us-ascii?Q?asFo57ZruL+Em4Fihv2od4wGQc6mHr8SHPBZlNbAhRiQEp5+WCvYTE92AUjC?=
 =?us-ascii?Q?2YKDABxuJcGZ5VUHG9ZBqMwgN2rFXIzoqDpZztcX6M1Wwkve9AYzZQDMtRGQ?=
 =?us-ascii?Q?/BuyIjM0+havX9mAoMOXav5WH5hy+4KMis1ms9V3f8PrFx6PALr/WySPj1aU?=
 =?us-ascii?Q?IWPbRPX+8ZRavT0gRjQm2n+Wpe6D2S3koN3+jKShm1b4w8msndqdnZXt9PX3?=
 =?us-ascii?Q?nr+dlrmS5jpw25+OFxcMMdq0BfH8neN+uELL3bjjDEbau7HXSi8oCILGUYvx?=
 =?us-ascii?Q?vVtiBOZKPTKvu84L5Fqf8CHctNk8gr9hJHkaVNVmdGwqROizdTeFWv8m/Xpm?=
 =?us-ascii?Q?/jmW6MArsJmPu3cRRpIN2BdW8Lewu5xaa0VyBtRRRH1JIzJ2faljCOla8ACf?=
 =?us-ascii?Q?10s7RFdLQr75OG1VDIBzDpBFXf+txXQwfoJDV9B6OB91u2r4twv8EBCCD8eC?=
 =?us-ascii?Q?QXtgbltrNgkT8tDaFwSyhMDWxWPDGJNoMWZXFMGkgM8Q1Ivy2X9x2vTdogbT?=
 =?us-ascii?Q?bvoSb8bMUfKt8rgxQFtqlDdifi9L7oaxAo2Hf/gFLjgx0id37a4IhMZ333jN?=
 =?us-ascii?Q?QrQ0U2Eh8VeBQ87B9DT0BmPgfGjTl7smk4ZmUNLZC2xipu7fNEq0AXsiWX4D?=
 =?us-ascii?Q?BdKxY7lAKdr9ZEw=3D=3D?=
X-Microsoft-Antispam-Message-Info: X07qT7zkECo+6glToq1aCJbrKeSG7b84iaoyjeza4VXrohu7HScjh9NbBNRIq0+YpfXFFE9ZrnMAh/TDLTfHT44zqJVkSX1a4VeXAFC9yakXq3Ze8ODmshUZ1CSqRnm3rAF+m60sMvAUYnXuFL78mFRQW6lehUU4R28mVkytUpXq/uwaxQ5K8YbE4fYhAB6f
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3920;6:wTIgNfA0t5qMNumXFajaSsmwTZAEA1TvmtKtRHhThR1/5e9wdV7KX191kxjXxlFXXbL/vpcxaZnNXk0horcPCH9nf/nZ6mRIuUc+HIkfHpWO4bPu4oLdhM+YeKX46wp/ZnBxZCIzs648LryL27G1eu4ZihHPRHHyoGcqP5RIuJ1f/xiBkDl9JEBAQkvft5Q+gB88ekoxSnY5Yx2lCbJpKW4MVznTOwp+c2bU7hqlLeAWqXeHacwiCQYFy4Sy+0D/X7rLkXWbx+vpbMAwHZRKwOpeMoJ8Td1B37BxP1M/60jb9ppkr/85RM1JSXVRuhUNhI4Qvi+glJBsdVphWwzpuQTQb74svtZz3Wnn4QZITHw=;5:FiM1KoHJEUSht0wqYyXl399VGfGksO5Y5zM2nEPKQysJjQvASBpIKdR0HCqe2V5OO76azIGk/02tdW4IZ7mO1K5XgjoD9oFLaQsMP1pS0suyOi0nGC8DXlwJ3JZ2BEp38eGGKefd6UhXU8zmBWgABbCHumZ8A/oaqiU092Er9bI=;24:GieGtv9SBu2zRfd5qzLEfY1rjNDqCOGIUK6RsdMQ4RgnHaD/6rrCcRXFvgFytkATdS03anld25ClIgOKKKrxsQwkP2z32Pd3WaOmaZTgAW0=;7:aOax5cGcCRLTKx/rc9NQTLEJlHSRA0O9+TkOoWxh/fYxseMRM8blLqzxwZb94GvX7K4KuQ0H1+tLGj1rvV5h3K2hZlkcpgZEtMWYqzFNPxav+w6J3ANrZPUlZYyHI/U2uOrFzW6YlKYmxDFHuv/s6akfSzQE18z1PGt3ilEcnxXZY0T5otPgpg0sSxFxNL0IciFaY0xrA4v1bpH8ffbQn5qJn60YlvPClxhyDzBd6fulWTLGJDzvJEctNV0y8O7p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 13:20:37.2938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb28a105-2671-463a-d4f9-08d58ff7b3ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3920
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7tuoKvP21MOB3sJS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 22, 2018 at 02:10:21PM +0100, Dmitry Vyukov wrote:
> This bug is actively happening several times per day, if such bug is
> closed syzbot will open another bug on the next crash.
> This bug has a reproducer, why do you think it is invalid?

I tried to reproduce it on latest rdma-next and failed, so wanted to
start from clean page and see if it is still relevant.

Does it still reproduce on latest rdma-next?

Thanks

--7tuoKvP21MOB3sJS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlqzrZ8ACgkQ5GN7iDZy
WKclkBAAwPKo8/Lh9UMrvAxPlQ4Eh3biXU4AyZhsRhr3xfH6AnuGF8r4KCVZSQbB
hPYadrR94Cux0P6AeZmQ3dZvEKY3SiJTWmqlaNja1syeWB3Csr1WTMtxeiWfUkBp
jAlZJOIDMjicKkBB3ivzn2tGiCSWTsT00C73c792WBuswNLNXxSPceegTiEot4vQ
3F/nLi0JzcMexJUMuxJ5i9UexdgjNhdsTiFbqd1zsY/Qfnozox5BPqcgULHfpsb3
KBqAgi2K1ERTEZbAtqMJk2tjGPRfixc9wlZgVkCKlbTMmKJ+4ekbn5VTZ8QxZYlg
vCHiz3YuLQNGTcEKQ0HU3YY+KHtMxaSfEdasLCxTHaPBydWykxfWYKSbXKwQFrcj
HYzGuWeWo7ZPEDLIaoQU6GTyUCbv/dAqmshgaIzPsRgjkDV3HDZZt/pkV6I9F1ID
GvKJjYAcr8i37SCea/S1azqufVE2c0nlESDlWUG/2bJ4x/AmoR3NRlMrGn+uiOa1
RI3O0RAv2lIUZ/vFoltEm4O7fJyGtMj7ZtoJsdgN+JVhibg41hcj6hO2Ar7OG6/h
DQw/CPP51kHAAuq/4wxMvngoCEigkwTkSIbhlPP8XZgW8CwQ2GUpMRVEbx+w/XLQ
nRwBXYk+sOrpmMyV4lKpGFi+pC3o5E0dwEeBoojwa5lZ4rmdc0A=
=DYdL
-----END PGP SIGNATURE-----

--7tuoKvP21MOB3sJS--
