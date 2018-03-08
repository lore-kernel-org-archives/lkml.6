Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755440AbeCHGJd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:09:33 -0500
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:26448
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751603AbeCHGJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:09:28 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com;
Date: Thu, 8 Mar 2018 08:09:20 +0200
From: Leon Romanovsky <leonro@mellanox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rdma-fixes
 tree
Message-ID: <20180308060920.GQ15340@mtr-leonro.local>
References: <20180308164058.2ad5a158@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TxukmIqg3MmZ0Kmh"
Content-Disposition: inline
In-Reply-To: <20180308164058.2ad5a158@canb.auug.org.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [213.57.247.242]
X-ClientProxiedBy: DB6PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::11) To AM6PR0502MB3909.eurprd05.prod.outlook.com
 (2603:10a6:209:b::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1afb98b2-1349-422d-46cc-08d584bb2501
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0502MB3909;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0502MB3909;3:gZpkQR4Lio1HjxEojRYcSlReZjK3E1WrWFO0nA+LJA8lEkberlYpQQm2B/3DDA3UoIjapPC9cTh8leBO8a08vTLtpiRGOFIomrN5OUoTuVrK7LNqFuwDDlPTT+t0v9cVuKHRWGnniXOyE4bHdjji5/o7ynOimqrt+4mowsJ93tUjB4+aX/aPXfbMyCfN2JRLUDti/oGQUr1cRMliKNbV7Ft6aH38SpkuK+oGorx50VszGssJjOXuL32vHPkMR3b6;25:t2SPKDuSFoDR47jq/jd1hUqOIf4dx2pEl3UKdo0ioKfAXhhBPOgh/ZQrulGKRerAAwJxkACr+AesqTNsgDDPkyUGUtEdwyb6dsvmGaSGF91Q9Mmi+43bfur6RdUgtH1I5NUTgDWayFiXFQLjOj4drl+zbmfMH24lB2zCPdqEUL9W2rzxw/BPWmD5VWQkSqZm13YohHpnw0CktJSy4sCA4A5NDYfgb/m+QG9+baDAQpZdFcSsP9x1GI0A5nN95mt+9iSRWKfBhiGMnW5EpmuSyaeFKRC8JpHpmf4NAGjbWU83Qf6crFrQ3g3VTq8jCaMnE3WfpGfYNi5LGrRqMIH4jw==;31:bx6p0jfRPF2T63sf0Zm4j82WVwpyLvJMzyMkjcDp97XqdQ9eGGaX8THXxA16io2HhceaUUJT/uu4herfY9HryfEDZxNtDoQi1n4Z/N0LRhSSD9L62KUYFB7ltDfvErIqozjigVZUZ9B9doxivp8CClveH205PI94ieoHlZA+fcezARNa9pSIUA5KNsL7/n9Np56ZbA+UTcAKqz2PFjo/JKSYhB5YttGLhh/EsgPa1ng=
X-MS-TrafficTypeDiagnostic: AM6PR0502MB3909:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0502MB3909;20:M+GRt1A2+MvUEYitO83h8BR6aJOQAf2jwgd8H+5jhHbjCH1ebkT3HNpY3NVfrm2Vo0yJp1hAbiMDpc/wgN5I9SYHDevF38jm8jLRfuScjlPrx8QIfxRVCHSnmd/lKI2q2Xx9PmP24mCNzbfXRNKbSVwhqhUAZcb+55p4TyqpVUvRwfKru+igJpxQQY6tIUNDMGsHeipdzmgH3C/Sgr38zkx5Va4031JpRxMp5HCkK3tPeXKZvStc8orHeKMM4XTBz0fK7s4IfKNIgYoJr6fv3qskYfHjqlpSQ6JGFZroGdeMwag13iw+CThuDtFJylQptCUUSmHlOCI+k0YAudEPii5DD5nZh8HvESruqpPUWXYtaYI5HQsmjRPELj7G8E/1ytIrreMVCWVqwhy1W8z6ldwyF/VDtZoGCYOoICWsGF+ULvUpfq3Ijhm6pPRibuUvNUPdzkvoU2ZR6i/yabxssjZG++Bfx1vuomjgE0t2Xutw6EgKFKNAUtOItfzDBy33;4:OlP0N1wjNTHG6O48A/V8Q4E0/0EPgzo/hh3PexM7XfjA675UFbcRtyJG+HH1h+pDgNRv05NuWJ62UwihFfyqDBKujGxeH33PMfKz+upZX84ZhM8lBESgmkCHHnriCY7Uf77x57nOkCQhK1nlVSdWASqZ2k+5A4YOiK0Or6zxwhZu8qHfhJ2GZRFWHl72iiy5zuxuBolFyCrNtp7CpHszwBtKgVTwgSQHle923f1bw/3al+KjbDG+apXc4rD09LEFznQzT45APhHMJQGauzI7ouBrNSv5Zyrk7Dc5fi7S2ub+VrB4rc917aGHH8GHyUnb
X-Microsoft-Antispam-PRVS: <AM6PR0502MB3909F219BABC3B97DE01C49CB0DF0@AM6PR0502MB3909.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR0502MB3909;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0502MB3909;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(39380400002)(376002)(366004)(396003)(346002)(189003)(199004)(53754006)(76176011)(316002)(63394003)(81156014)(966005)(76506005)(68736007)(81166006)(16526019)(105586002)(2950100002)(66066001)(8676002)(86362001)(58126008)(110136005)(16586007)(6496006)(54906003)(52116002)(575784001)(6666003)(97736004)(3846002)(6116002)(6246003)(2906002)(4326008)(9686003)(6306002)(21480400003)(53936002)(44144004)(25786009)(33896004)(386003)(229853002)(26005)(33656002)(106356001)(6486002)(186003)(84326002)(98436002)(7736002)(5660300001)(305945005)(8936002)(1076002)(5000100001)(478600001)(18370500001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0502MB3909;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR0502MB3909;23:D4yS2CSTJYHRc8eiogDB+VXXVjXop+La/XOuVqF?=
 =?us-ascii?Q?EqljwVE47VFODqOd5AXVTB+Y8qovsXjMeezb2t+ClwPpAKFCS3e/yNOJmyhU?=
 =?us-ascii?Q?Ua1GXKKaMFMjN05qbuYmWn7BzpOxQR8/cpMTgakRoqZVdEOomg/SUQqZVCMP?=
 =?us-ascii?Q?gWUK2YABytt6f35iyorNd7N8sfMgQH4NSPV39m4K8VTu317SJwDcPqHJV/ra?=
 =?us-ascii?Q?g7i5NKvd5buzdNP+Ac7WluyywLLOrcTj9mJj14Gy+Htn1m68QRtT3Bctlx1y?=
 =?us-ascii?Q?NON/O5/hWo5gzjd9k1ocOM8r6bHjkwuBTWTZF+5lobXIZSd0F3CTDuh22Z4u?=
 =?us-ascii?Q?vRa4ZsB2LcxS0beb3lez04MQjaBH6LR30CpOLGb93tTr5rnom6+COzSUCevA?=
 =?us-ascii?Q?b0xxwSSLPwCCvOwoaLcMWHwUrBCtVxrqKOWFi4ZQQKUOylqOcawnE4hJfJc9?=
 =?us-ascii?Q?Iu1U6IPDJ21ueDPtd+osyr6LU9XHJFuR3Q4nf/rHxYLQuSuwKa/CCvnWjFN9?=
 =?us-ascii?Q?ArS/7J9tePFahzdDd5UGiTHAcf1Ole9lQvxHXOxZR9KSuuhFAmiZcDS+eiYc?=
 =?us-ascii?Q?ZsKH9am42WATTVk0QThQd8wY7a/6j1VuZABDj+NzlY5P5ylHgT2pKVJQIUZI?=
 =?us-ascii?Q?gUxbkGOsqUkSWnT/WlEOWDQjN4yAHDKMrXZ6u3BMFr/QvQny5oQeIPMfAlOS?=
 =?us-ascii?Q?2fPngtAQcGUmLoRFSv4YBpXiTySrTBOKCgVFh5uXF78nhzR5Yiy4TZ/zNfH7?=
 =?us-ascii?Q?y/jvRyOBQTlC72GHBYVytwp7Pn2j3qNPta8N0GxAlVelWR2j3xpQQV6Nqi5q?=
 =?us-ascii?Q?0XejTZ611lP/tzEwyXKkgkvJnyQUTwTubfuG/IP1t35Y5eUQxfjn0qd/SsuH?=
 =?us-ascii?Q?4m+gvnS7KJF/JNUtaRQZGEKkwG7Gkjl/UZ2RPZs9KNtZNfXVQMsfeqEMBrd/?=
 =?us-ascii?Q?ZXwPiuxL3pXaksELjwIuHHUm33P/I3Zw6SH97a1eHIQJGJ/APzK+UzqHvYSN?=
 =?us-ascii?Q?VEFA+atNkrmdUni40j+JrJTDMDgijOUmvAXntA/QodgRrs2GN+aySnQc8elT?=
 =?us-ascii?Q?mwztrs7RzoRP1PRGutACG3yJ7X9WDoZM0YuDs+q7mCkANkJmQRpBLQPwyEnP?=
 =?us-ascii?Q?HCkYFON9amE+LjrBGFkHc6Sc+/g+FlrltxxIeXXHXmYVrDCxFfGjG4NcAEnH?=
 =?us-ascii?Q?65Q0sGNgEUW0040/Ggehbgi80zR5R0yu0oxL0bOM+12dHEJR47Qow41f9JnQ?=
 =?us-ascii?Q?ar98Qj5d+xtN7UbK8bArAngOxYjUGKFTaOEdcAoLKcChx3cr/CDFWyoo0J6x?=
 =?us-ascii?Q?StikxkP4r+sIZ7UDTZcWtYGHqg/nDY3pvv/0/pWnaucxWAkjYp8Hk2lWDMUP?=
 =?us-ascii?Q?UPYWSwNT/IQ1iboE8bHKaqoRCNM0E4AeeNwYwSzaFliH/AlU0AhimYBATyPt?=
 =?us-ascii?Q?JlXky66sm1w=3D=3D?=
X-Microsoft-Antispam-Message-Info: 54gkXjIbo9I+stTXvfgaj5MM6yXTH9FkYgV2s9c6Tuo3z+51Sa20lwpyPqrv4+ym/mGjO4VHQXR3oRE09jzPxcBjtnrXJ/iFs4IDDFYzrCRWEnu0DNmaluSbONS5PV4z5PVdmix91Nwj83T4K5uS7lBKAs/j/VDVhauae/dY5BwY2NDmIIdhiqWoybS7NrbO
X-Microsoft-Exchange-Diagnostics: 1;AM6PR0502MB3909;6:QCBVHNKYbstFO5dJRKZbPn6Mq3kW/nbkev3V84BkVmct3dt5Tb55VOGPvT1tT+JZ3Ymt4GlgqC9zxUDgQ8hWO5+0etyVu1yDMGTK738ZZgEtoyXythnFeWp15yEdihI/QGYtJelbGq5+4rTBsRRnozrS+D8DpEwzHPKB44GbpMNGF7k78KQbznlqsgoDoxevEOXHEdwP2eNpIROTwI075Dl7cq0Xjj0u6chRuBgsaCGdsSzbTQG4NjWwUAMd+vnQZqW4ZH82SX30kc7HK0hwnrzpNPZcBTtapUahuy9R4NDtpa5lNGkkF6YLc3EsWJSne9evtrc02s3im2ZZ1AFW9O628V7J4hVi8jWhw3ZdMpc=;5:rnPkkcs5YE9Cvcj2gdASa95kx5UJZ2nKNPwRU8TEgwRKt2QSRtufRs/aIYRug12HgIzGfsLwj/DpBl7f3XN/9ywijYiDReXIjpcuGbXsh3OrZ6Lg+XcL2YIXXKYkC10Ezjx5q5/kaY6lernz8SDl7Uj8dXDdXBLmDASbCMRYgtc=;24:xMLlrQvMig5bIixB7a0cqzb9IKddMD4U8ayall16uyjwdxlESts44oxfUZmdm7L+Z5hcrCr02vK5sjSPKrufpKREaBrZcjxmXf4c6KC35YY=;7:YD8/qZiFggJxHMJHs5kDUPwMONJ6mMFzD5iA8MTLMHKRbkhQI/pTC7Io+BaM9YKw9/W80QO6aQP2rHAMDv7Ael5WNt+AUvdYxAKfjkuhZhmM/8kbJ5bOq7DR06qmYVLsxain6wZ1wGOjj0BZnNgdAS/fHx9A1bh3jyVwggzqJc1L0Ue+2rqSErzc16yJDw0LRbos4iLWi2ie8n4/ya5l1m25P/1m2PhJ3AnPhGgHMD3xsQ87d9ueItEy3Ilw0FHR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 06:09:25.4103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afb98b2-1349-422d-46cc-08d584bb2501
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3909
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TxukmIqg3MmZ0Kmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 08, 2018 at 04:40:58PM +1100, Stephen Rothwell wrote:
> Hi all,
>
> Commit
>
>   aa0de36a40f4 ("RDMA/mlx5: Fix integer overflow while resizing CQ")
>
> is missing a Signed-off-by from its author.

Doug, something went wrong with your scripts

In patchworks it is with SOB and lengthy commit message:
https://patchwork.kernel.org/patch/10264089/

In the tree, it is cut:
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-rc&id=aa0de36a40f446f5a21a7c1e677b98206e242edb

Thanks

>
> --
> Cheers,
> Stephen Rothwell



--TxukmIqg3MmZ0Kmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlqg05AACgkQ5GN7iDZy
WKfRhQ/+IZU4ysCMzB/R/rFY0lxz12aVh36TMFWBkgO6zB3Hbf3RlhNYmV4v23qe
zQ+hZDPrScO9fuqLHCMNq78TKvJLdicRg6DZFzv30FTtaoy61JZ+j/b/33anPOBD
dKv7vuzTVYMUCwLlnk0tUBd2loGeGAJS/QrjE+ys8z2aNT7Vv5v+vYVIOXX9zJH7
91PzLNd486MdjpZcPl2x1Ek9DyyvWk+cH3a3XEvQrrjbAdkkvUunqj2ll5w/BpHK
qpGbQrCdn2ik439CEXrFsgvxTZJijFwWZdaJRhyq6zlv3kc1k+4L64sMeo8plzJD
IPXpKu/8gsCORKGhAC2JMQTbwTaMt1jwWMqo4lRLFRbAeGKKwqzzCMby8zpnwA4t
sbfGF+4RSfVNW9+w5c8hBEshbhwsyvnHrkQPwulnMxGQChhURQ+QakWphswXZqfv
VL4nD32Kz33P0eisLJcvbfEp5kB9+XgMhc2QgzZ4aZDMVPrpQ4apNUMCVIoy6rTw
+iqWLXcoVT/CEjk7zcVIIqobzAUlIid8nAQ0xQL+E9P5sactSetXcXAKlzr4QDjs
MR+NDvepda1vNlg1VcnaN7J+WMF9AJxT5zoUFaxur4+boGM/dY5TESM9eW65bxNM
PwtrX39BOWpG0d+FPQSr2b6lTtYjM6nmfIRnTI5V9Ia6DCWn2YQ=
=3ftX
-----END PGP SIGNATURE-----

--TxukmIqg3MmZ0Kmh--
