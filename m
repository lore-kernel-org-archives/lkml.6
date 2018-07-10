Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670DDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E82D2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="s2ISX8FA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E82D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeGJFT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:19:56 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:14092
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751103AbeGJFTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0G5aOtAGninBhqjm4dHso5d8sGWU/hOLt9hzScrE68=;
 b=s2ISX8FAFGzHrLg9f+GMKmC+7eYPhBy8Xj7XFiDuU7UMi1qelcQz+I5+JJjrTcEi60WTDojNHr7gsMHTELFZNSpb3O//+qOuZsDLRLoJyLSK4exAWH12YmPSGHOHVXIUca0v+ADLRE9X+lupbcwo0O596j/0dhHPmuCXIh5ar0M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from localhost (193.47.165.251) by
 AM4PR05MB3252.eurprd05.prod.outlook.com (2603:10a6:205:4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Tue, 10 Jul 2018 05:19:38 +0000
Date:   Tue, 10 Jul 2018 08:19:33 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rdma tree with the rdma-fixes
 tree
Message-ID: <20180710051933.GM3014@mtr-leonro.mtl.com>
References: <20180710111740.5f345088@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W1G4cAX3lNqeBRc9"
Content-Disposition: inline
In-Reply-To: <20180710111740.5f345088@canb.auug.org.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1PR0501CA0034.eurprd05.prod.outlook.com
 (2603:10a6:800:60::20) To AM4PR05MB3252.eurprd05.prod.outlook.com
 (2603:10a6:205:4::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e8b8c52-0aec-48c5-7233-08d5e624bc26
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR05MB3252;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3252;3:/WNI2fsgZk8sioT/tdEe6ss41/245ORHlaGTfajlr4K8yPC1ESdsk4h2yjo3rb/HVQkkLTVUy2lc1OCDRFgIeyQW8/u8QrZ7lZUnnB1uecMET8xP2TznHl2PNVH1BlYBEeVlPkO2qWbE1M5TMytGPsN8f3gamT0egHrgiTaThahbVFxG3qNCl9ZxtN8iEYCrLwK764b1SYv63FLGjC0kkHw/Pch89Vz1LY93XPpUuejXq15pA1+7l6CzNInblKRY;25:32Nr9/gzPdKSXHczT+rbrw9OqVT8LptzVxumSVPmfe0S0XHkBnMUlulLQtwYmwLZY/1M6y5ifypXzgGvn6uS9ccmjQAAXBNLURUMGwZe1tCoDljF0ZwJXNEJzi5Xt+46cXoNB03rY6Nv3IH8B9fmViAsBjhahoEJdE30bGfjomY6pWeIgcylDkpwNHmPIs6i0xjdJGrxzUECr/hYqk63MRl4HgV9B2X2AFKQp4Gd4RqltfiV02Fy2LJyIMFGP+DNIJju2VmhoMq8Yo51A0h9frG+uGnNAP3k6A2D08Lp9xQRJRcH13IqurNBoah2/6Z/v0e1HO4DEw+ApxLSeQw1kw==;31:nybOKv3OZZAorv28eNdaMOgktbV7qgx8TnCW6d/YcRIdwD1r8mUHSSUUdyZyel2I/xqpvYwc4JzHMT1QiPW+0JTqk/J3r7kHQ00KfIZMGjvE6819evkYqCxJ5vDDN7pZ/IkOGn7NUXWQVlTmlPrERdHN6ywwp1YWY2qIkMqOsFDAOepJDhO1NHQ2j86gePCJmZQVu2t3sgCFwZUK9JEhLUO58U9GQxIOs4HC/aBlR2c=
X-MS-TrafficTypeDiagnostic: AM4PR05MB3252:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3252;20:Q8R6yBB0rCeIuc18DjYRLbzlTfIAHFkKsMODTYjSC7NCAXccknhW4HWW3PHXyVszoVCSDygCLAVKhtNm4as9t8JG0/NNbi2zLUNSDrLkj1PP5CHv5flDNSagEepMvVJDfphPIgLxGk9A+fh0lGxcmtP4DQpjAwRG30bQB49OwARRcdcCm1MtF8NNpPwA/4hU5WrixwTdyksRW7/mnns8Hw1Pu/v7USciuhl61bjAN2zB8aDMSO845ht2mJiVXvfEvjPFJKCKncOIc64TiN3bC0nm3EGoCo+IXhxTHA5mLhbApI0I44CauJ4q4OvBzQHYaFzKRiF1Lsm9ixg3VrnxZpuxujAAUZlRQnVHZi72ybsQ77FUGtxcFgYRlPZR2ogdy7GSzx0BYOqei5QqJ0JfWogxK3UYgcQexdFy1ylWNLUpqsQK/4Xyqi35UZSh+hMcCtQjXj1vOQ+/RbOK9nu3t3g745c3oubGzte1KMeVTxqRx92a2C/g8yjlp+HYDs6X;4:28JH2reyZ6m1FRXElD/4d9W3nrUQaGnrwTLchUpwzEDle1usDCFEyyeWKJ+Huxcf2GaG/yeJ+iGVXWe5WMWLFpiKdsQ55cGqaUHmMmozCFR7ecPjvQJE9KQWjbMytXR9pg3l7KAWDJixP3wjT1ZLhhjpoKNWRNIVdM3nd1DVcivcqIEDyUM93XP6ca3TV4inLsY53n9tpwraSVk7nRB8VxXLHGSxGFm+ptAOadCWXdv4YnFHDZPOmcnS33EyFUYLNYS7jL/8nqph0F6ykCr/w3x4TOwL6yK4rrc3crYVuCf44EgEVbtJ33ILCas9FQ1N
X-Microsoft-Antispam-PRVS: <AM4PR05MB3252DC9853711981E436C3DBB05B0@AM4PR05MB3252.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM4PR05MB3252;BCL:0;PCL:0;RULEID:;SRVR:AM4PR05MB3252;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(346002)(366004)(396003)(376002)(136003)(53754006)(189003)(199004)(21480400003)(1076002)(97736004)(86362001)(3846002)(6116002)(53936002)(76506005)(44144004)(76176011)(2906002)(316002)(52116002)(16586007)(9686003)(6246003)(54906003)(25786009)(68736007)(58126008)(4326008)(106356001)(105586002)(486006)(305945005)(84326002)(476003)(6666003)(66066001)(956004)(446003)(478600001)(6496006)(8676002)(6486002)(386003)(16526019)(5000100001)(8936002)(186003)(33656002)(81166006)(6916009)(81156014)(5660300001)(7736002)(11346002)(229853002)(63394003)(26005)(33896004)(18370500001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3252;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR05MB3252;23:gP7Hii3cmDduEUNPn/yDYx5hB6CuV5UcL38wCnzYi?=
 =?us-ascii?Q?Ylk8xK4nzgMpGdKzRB2sCk1BE2j/j/maLvT7lYNsKnOgSUZ0zzBYhXlQiXFG?=
 =?us-ascii?Q?9v5XbbFRuQi4qQ22uAaB9t0Mm/bAtFi60p22R6ZktjQNCg4Y4ALomHw0wmxF?=
 =?us-ascii?Q?2JMlCIBfgWkFfY3dXe/CZUfn2ZHa42MpHsJnvwNcQEqzg8sUgVtzzAjABYRF?=
 =?us-ascii?Q?oHjXxUWe70pgry40eQZkRPzsjq0if+gS7kUXZfSJ8nvh+IotJN/WOwggcxXR?=
 =?us-ascii?Q?v5/Fgo1y0clnDN0MROawxd1BMtzR1UY80nmerz+foGtEYtlsF1Nz1Mh36HzU?=
 =?us-ascii?Q?7mZrygiyH4tnJFP2vWmVWq9CColl3hs1JYZFVgOHp77ZAB7G3CPaGplCSKy2?=
 =?us-ascii?Q?RkU3Wk1JU+6KelaRxxofljgp3hF1LrWLUaOVEwdjmTczpOqhDfCxYgWuU26A?=
 =?us-ascii?Q?NuSISSDbS9s0AVcbk4XqEImiGG5hIW8soCXg3qbqHQEzay4O7JXeY9D1RJdl?=
 =?us-ascii?Q?Djqtak+e8G24Ftez8zmYV7WATNepNn7bNObarb4bCSj7iHttALfYDqA+WbqZ?=
 =?us-ascii?Q?Q/C6yrKwRydUy+WOTVqw7uk99/RAy23A0XI8nvtzOUw2IpRByHnUTR+JYwn1?=
 =?us-ascii?Q?maYSYAA3vFoAkbnN1CWz1uBVrC9eFrRFXjXvyCXMf9Qplh5JwQe3djBBuHsh?=
 =?us-ascii?Q?YDLHrXpRFs+uN+M/FpnGY43JGQPQmzo1Ckl4iNx0SV6Hp6fsT2K4TyI0xunm?=
 =?us-ascii?Q?IwlRyLl5Wp4wkmMIsjpqXQ8wIMRGurHqJEHDiJFvqXBMYhSAkxmAEoEhhpRm?=
 =?us-ascii?Q?jviXaDzGESiTGSQ3omP6PIAthyPxQsD/EwMzdQPx/LoYnvcapBy8/btfDNLh?=
 =?us-ascii?Q?CVue96P+xEj+YE5kmgTAQhnynGrA5PJF+08oQPMlK571LuRSm6sjcFwXNxg1?=
 =?us-ascii?Q?sRlmJ4U1xocZF6GgeowShN4OGO/2CpxIVpN7BornHM3jdQx+49vnSsIMXhij?=
 =?us-ascii?Q?3RAsL+HmZj4vH3DNy+rXaVsxKsVrRHIclSYxD2yW0iFoYBuM0q15RD5ckr0H?=
 =?us-ascii?Q?Dl6w6NVkdZEo/pZsAEEhNS7YHWwrJum9lWuCdtKmWAP51/cQajOoM/72b+In?=
 =?us-ascii?Q?TwQqY8mbayau97ncJz6N5tOY2qNsBYenCt7MYi5TXyxmoeUSYQ7JYZvkXgcL?=
 =?us-ascii?Q?HUP0PuhG/As8k9X9UoUD+gvH4UojQ45eH5WFb4ERwgA03bwrRwXbtmvA9SnF?=
 =?us-ascii?Q?A3TOYq1dwalwPdpizok4NoYKpnBtjy8U1COzvE7moY8ycDX8AGl/5gr05/pI?=
 =?us-ascii?Q?J+4N1/3j1j2TbntNN5Apc3vjarAg/3QEEGQ6Fev02S+2Z8UkmPSlv9IYG8lg?=
 =?us-ascii?Q?uYNLLJZr/DAfnXJRuDFe+9MaSCFxreDUgvpKxYakTl+yl9y?=
X-Microsoft-Antispam-Message-Info: tbXNDxy3roXPavkkuNCdIDvnd9RTvhEhUKLo1/fEvsVMOpr6QSPenDSGd4YThXT3NEty22DEKLDTel7ip9lH9puv4e7ln7jkSrhTLa7aanGaWCliPfR04q6VVtsNbXOONQLbLGaJdJqrMrqk0a9otAqaLUdLZ06T5VHSsGEL9ZOph4Vc8bBVwcc1YNNc7CS6uBa3H+wMTdpQYQUNH+nGqZgzn9peqPaTfoHMv2mq4FWW9jJaLuwcZ3OfxHN94/U0Hn4JC+ctSgBFt7hC7tUm2qkU+9J8wpCXo4BG6DEBWN6+JQruKDaNGxGlAGsJ8h+WML2fizYEl20sKaLz7RtFvooDUwJU2Tq3tl+5VKLHqsE=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3252;6:8EIk3RFd+y2fMb0Ax9MsXe3KHUFDbZTRG1CXsGRlNcsg8k9SnQiGtDf1ZqZ46dAaS3EtACNchvclfUDvqZR1fVe7fS0+KwGtccLUN2iFAKNxyHGwlQbz+W9AgWkDppXoulD/zyApAJAvp5a7z3NqYtBu85qwYoVqW/RUIxbNXZdcqU+R5MB8TN9Cm16obloIrdUe9+K/fgnwbOJMMOClQp4tbt4ygMnRPKoR1A2GKIwWRI8YBZojoxUz6EBQUE9sBvCwohCGYcYcXTqcSToAlmfRGT6kMLA9HjiRAQeIffEXBlEzBbHA3p31udWka2UOKTIZu02e0ZubC55nmT5pho/jIC3YprKTQZcw8IPuRYaPNM/3zojq9s7yTZ5+OuqciYkkG9UR6O7TlbGAIrIycYMRZzJWOR6Al0ER0k/Xx8cdsvKWldP0tb2JH/sA6ilOHLs01LACXxKXpCXaJacgnA==;5:I98G4Wx0EVUYH8Ekc2SeEl/jpdExTo/ED+IC6OvSmKP4rFQtypauirFhtF2NZRLmL4WYkjzvOmiv5m4ADVVHRyFN1Tah3uT/c/qeoE4sOIbpsrmrQzq9s7qQqm9MaIG6j7flHXalUTnUHdbIRSMmYLFZu0fSwf2J6quWHVlfXrQ=;24:4S56UI8q77Sc/Km1F2yKlQBlJ6L5fvZqx+CdFZSv6lq10AZu6K6LY0st3iDalz0T6W9eLZHNfI+nc6XDspjk7YezB9KDsG5R9FJBEg4L888=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR05MB3252;7:gOZOxpP1w9L6peyzwOhwX7UK+TdpUMTRLPkYNd91OC+eg59S7STekHGOpLl672Wd1TePHsT/Jn3iDx+dWZ6N79HpDEqXuaUY8HEK1ecfgU4evS+JlQgz6aRZ3kewn81Z1FLlSd70UAcT0TZs9nyRdabTxQfj65WTZ0FBxEblqSwBgAMd4U88yeiE6tFrZhOslFIaGdeM0op51LK7PfYF//kS8ioE8bjFMRVvc+js2Rbjzb2il98yGPXXoCfQSnuN
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 05:19:38.9838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8b8c52-0aec-48c5-7233-08d5e624bc26
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W1G4cAX3lNqeBRc9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 10, 2018 at 11:17:40AM +1000, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the rdma tree got a conflict in:
>
>   drivers/infiniband/core/uverbs_cmd.c
>
> between commit:
>
>   4fae7f170416 ("RDMA/uverbs: Fix slab-out-of-bounds in ib_uverbs_ex_create_flow")
>
> from the rdma-fixes tree and commit:
>
>   2cc1e3b80942 ("IB/uverbs: Replace file->ucontext with file in uverbs_cmd.c")
>
> from the rdma tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --

Thanks Stephen, Looks good.

--W1G4cAX3lNqeBRc9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbREHlAAoJEORje4g2clinnfoQAMji/2el6Ih7MaASVtQVqUaG
HG0fX390+Mm3eBit3E/RlNE8h7igZodEi857vR1bZPhumNbTW6XULzXxM8g7s2qK
Zy7wUq4xSTjgPrylyYiPu+kEDmWbXsbBbeOwyPPWbCQ9SNI57+D0IYz+Idr7ViIZ
yRURHbrjZaNwgeA1ez3TEABCnYBYkidNkALlDVV0K22jDuhVEKc25cM6QDwEkGmF
k36o9g5C0YKN04eAmiHiCv633xEy+VBG0psTTmuZ91PdYv5B9ufMythU2ac7WVK0
4YacmjHbVQLPEhJZ9wFF8ob3d5lsM3EGZdsnO8pTFRTs7184xHC47aflLwguyRpE
truyMBwnOQBrohpd3rCsm3N9l+uf2cE6oG/VF12ZIKfgyelhrq1pRoLLvuoygoa9
6EG01/cxV6Ba46Fs1xF8wAmnkTN+vkvpFZDnzBR4fsuvCTKmb8th07+tvN+sTRQN
Rrzwra9h6UujHHRZOhAoUCKPeEdX0P71LYPdh0GtK4LzJwgQ5h1ZtfOaVfyhvDF4
AV5EnMvJaJdnZrlPPOlbdnnF+UbLiQoBG8jesgaWJVv2NHrzZ4bhEGonQUv6tAtQ
bj2GQ9lspb/ci/POEdcX1uqoY/yRDsJwjhy2Km3wdZTuFnaHIi9259A++RZ1s0vv
3mnWoiY1tYe4ndARmTAJ
=tZj6
-----END PGP SIGNATURE-----

--W1G4cAX3lNqeBRc9--
