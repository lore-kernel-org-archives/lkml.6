Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9172DC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143C726764
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="AhK7tTTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143C726764
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbeF0FuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:50:13 -0400
Received: from mail-eopbgr50074.outbound.protection.outlook.com ([40.107.5.74]:4008
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750909AbeF0FuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHALuIOX2YFG+IeQ1dlR6Xmr5EWPD0Ja+Cvwb8pTu48=;
 b=AhK7tTTLvBWA9SBHSHAZblWXb6TjKJv2QCbMXbBNPFCO9Dhdk6A3H8T80Hn5u7Epq5Thezc0OXS47/e67dlEiUQusr0cAcp1eyrufLEuZr07HJ0RUb1EUZ7gTZIs+mHlxgGKbkEOixBA9WTYicbyWXqFKBOmtwrjVqcbb30HBFo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from localhost (193.47.165.251) by
 VI1PR05MB3262.eurprd05.prod.outlook.com (2603:10a6:802:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.24; Wed, 27 Jun 2018 05:50:06 +0000
Date:   Wed, 27 Jun 2018 08:50:01 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rdma tree with the rdma-fixes
 tree
Message-ID: <20180627055001.GI30877@mtr-leonro.mtl.com>
References: <20180627100726.0092e8b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <20180627100726.0092e8b7@canb.auug.org.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::26) To VI1PR05MB3262.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9f3dc0c-edca-427c-0d16-08d5dbf1d632
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB3262;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;3:2wbKKvFDKcNXiZ+ZEZ/qU728nkLVjO7tPriuviief6EP8twae9HPqMvrFYhOAEhXOW3Ouhg+bOhbweYHcEWGuNVsu8hkpKZQiZuZSIJeTxJH87HJQaa9wWsOs/Uv3MRaYVEyUkNQLrwOYL4ElW7+kt7W8cryyjtwPDhLvmWrpoFq6oydni/aUYVNAGvT0tz/Sm3Eh9Yodd9iTwMEHq54oBbR9wff3caJTULlqOPLplhhzxUZlmrvuDQpLIgxTah1;25:Y+SEUu6dZHHyi9xjuTPO7Wv6PjgUoqRRT5OmMpig2vdBKSn1o0Ty2nLQUXaMsKzjmQ72pdnXRaFiPYmNtaC7DKLa2dShVR8eysHEhMNmfK4dGug8GbncXZG5yRCJH8+XYf6e7LZr/ouHVJFP93g4Euq5XTS5KWE7hqKb94BrId3CSKZ20/6qkR73cCXWo5HL7v864lX3UmZ0Cl9lCEKg58UbeWwcZ+hXrNLQF/SRgopAtdrHpz7Zl5Z2JtR6pJrcomZu+rJoMThVqQIFwf39v9aI79Hko9jXuJBcxGC64KKwYxWzdohHMlzcl/h7dYx8k724yqQWm9PsnVwkEbIBMg==;31:AOLwhglSWQm1eL1LG4UXr+G0pj+Y8riXe9OX8ASsuwHH0IQvZoCQKY+yux0vIaa8U6uTjAb2HopKc8HSsjnhBW+lYVh2ypsRv0cHLr/xG76apBOTMVl12VKN+mWG+QdABe36wa3Us9bzBTdEgPqa3Kwus+8g4dDAENMd3VDmwZbMYbhqZgeIb6p6CkzxEpCzvm1pX6huZkZDh9Eqz/+UN7ngdnWK1jpLHR/tV3Eg24E=
X-MS-TrafficTypeDiagnostic: VI1PR05MB3262:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;20:PRWqVPHM4POA1ccZMPsuec+vRhrPdaxqvs1DO7wBCeh87IXyFgzRp+w5WFxM3Fpe6EO/6RQ2EpFJqYeqPhaD9gFXAwTibKq7KCFAuuCGw280hvtLmds4DoVUFUXGUjbejYURgiOEVvDdvUFp+I3fn6opW0Ums6TqKyyOvIbjDzWXpIH8SFBVFXDvzSZZufzXz0GfCfjEIMZqc9wlJiZNYxOX5qUD8ZPPgbegf4zcoeARLVjfqkt760ggy53xKvhk0y0ZWnmw31NvXKf867T2RCikp7wBv07asqhsb+dqRGaYsKwTTlpnK8rY+ipX3lh66FJynEmEmC6P9lssClYecrXG5NIQkaHPCeIpMIK+UBSG45eDAs3aklbbwqScvjwoMv0B0X2lnn82NwX5AWRWs9G3fnxYJAs0yloVYxXWDwkqhBx5aSZSTYOBXfa/TFbUttTK15GPNQ3ro218/EN1Trn4Nr0QwR48eQX+OZzL3D/P6DGalHAQwhVrsdf8WxkY;4:rxfo1U2PVAslK7h33tzwsxjf1/tcbYOmjUNqzr0hIm7ZrFHxpPFISCeCoDRu/3TUontdVq/yxbmwANdeEAxkJFqNqPhco5VfpSXLvOOREOAhx4EBDbzpwbwpps39X55HPER+t09oM18kVj1diozkXMSBokaca9m0B2WhZRSU0OJ0Azx73MZyhs6rIyfvqway6Yp/iH+ZM0c+XqHL0FwASnF+PcvOCtNj3iLFkY1xbwilBPrQOIhFGdjKiGzTCBpEfrWHEHaWLeRBxACDxlQFXg==
X-Microsoft-Antispam-PRVS: <VI1PR05MB3262B979F4059B9C8820E121B0480@VI1PR05MB3262.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB3262;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB3262;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6069001)(366004)(346002)(376002)(396003)(39860400002)(136003)(53754006)(199004)(189003)(105586002)(11346002)(305945005)(68736007)(7736002)(8676002)(6916009)(97736004)(84326002)(6666003)(229853002)(446003)(66066001)(8936002)(6486002)(86362001)(76506005)(5660300001)(956004)(486006)(476003)(106356001)(575784001)(6246003)(54906003)(33656002)(6496006)(16586007)(186003)(53936002)(33896004)(9686003)(386003)(16526019)(52116002)(6116002)(3846002)(316002)(44144004)(76176011)(81156014)(21480400003)(25786009)(26005)(4326008)(81166006)(58126008)(63394003)(2906002)(478600001)(1076002)(18370500001)(2700100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3262;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB3262;23:NoByu1uv6zSgfRZODR2ZiC9UkkgdLFF/q0TaFZpRM?=
 =?us-ascii?Q?XggV/qjgwQfaKHYWXwGmhZh+vTkFNobaPgbOuQgkY2CGtKR61aZGSUVQSJuO?=
 =?us-ascii?Q?y/3RJS0jClv/9R/FbU9nC6U1zR0o2tz9qGfP0BNDVRN7mNtoKeQtUDrc210d?=
 =?us-ascii?Q?Xbdjs5oDUk+yFeh9h5AP9fdAwLMFmVFYWubwK3YBInQHeYhHOU4nyoPuVmd6?=
 =?us-ascii?Q?ryvKAx4eymgOk3JabTAiMQYkNv25QlnaX0THET1Qfw2wvXOEx1t4TEMHq18E?=
 =?us-ascii?Q?5ZSglbYCkhgpe6XG5oMRYqA9nL7rg6gjhNBbLvi1cRBMq4EMig8PDrTUCQin?=
 =?us-ascii?Q?6DrclQLZY8SIheFNdpPMEtsY00dU0Uea9PVPNTc5nMvZzxwAedg5cC9qfwH4?=
 =?us-ascii?Q?PQ1+P1FlZfB8GqOlO14HtIDN0PEUhNzgbYOYOd4P+0XZx3srkyW1aAoeKNlJ?=
 =?us-ascii?Q?j0V+B20hZyLHq3AYTN446cE+0/1Htt/PjteqqnMO3QvHVAMY7OUTW0728avA?=
 =?us-ascii?Q?pIkTRFktHJMaLc1T/VcMLmicD/4Gca6pixlu30ksLcGV7jtybZaLQkkw0JHS?=
 =?us-ascii?Q?YIuEjnVoEdxKhhK9LkJCf+TkX7AeERpWg3ti1q7MHtxD4gQ3l5DPIz6OUy/E?=
 =?us-ascii?Q?JA5AVCVlQLGNvz1hQPEvmzXhlrqL+q6z4qET8aTEL2886D51mgOAJW7JZ7rm?=
 =?us-ascii?Q?3+1UnsqDQz/jX1ahYgMDx79kjyNpQDTPyUM4kBGbmnnCQdc63vw8OaHECQvj?=
 =?us-ascii?Q?1/mL4Al6U9XR3DbDvyJmNcHwZyksN9JBlPSEBVIRjVkE22KVu+HH+NvFCzxb?=
 =?us-ascii?Q?yiWN/umQ40ZWr8WQqpBlYbWfCmKHNvVXTPrQd+V7vO5OcMXPRQMoACwSL5Wa?=
 =?us-ascii?Q?F92F+MPD4q2U3f+1cL6miIxXGb9VbmV+PyvKYTtVACkVk9L9PNtaSS+jnSdR?=
 =?us-ascii?Q?7WqTHrFs2JI1hCkbSzHQ8qcSssvRALdGdbJ/g4acEX/UNwMbIK9K3uMhe/F2?=
 =?us-ascii?Q?ofsXFitXkbnxWdllUGF8g2s4gBPBY7W9o/8mcdWEl/luaYbihZ2qDumnig7B?=
 =?us-ascii?Q?cA7/bYINX7SNl9ogU0F5pQJxV91jmIu2FFVr/7BN50OzGFfFKrEQSHhq9GXg?=
 =?us-ascii?Q?a2wahL/8NqD1TY/ftX1hEB6wPEvajyMLildHLdCAUUEjFXjpHMIecyPKeUMU?=
 =?us-ascii?Q?20DArrHRve8bzivUZoUUNJvU2+JgN1JFQclaYjocVDlwpWQ0BQxm7aq2JLeL?=
 =?us-ascii?Q?u7RVVwe21m3CH4Xwg1CgkpysbFcdDhUEfeZMDJKRMXlFF1Ctrn2KitH4jDD7?=
 =?us-ascii?Q?9m+4BwcACbP+S0sPt0nM/BtEJxn+2BQv86m0qiQG/9CR9R920W+N6Soou8+6?=
 =?us-ascii?Q?XZc9B2/eXIw9WuoQIH+taOt7z2xwSLbDzULF+rurCuJzjK7hWoVc5o73EtAA?=
 =?us-ascii?Q?XbYwUIz1eqRk3LYS/mzfNvd8TUJSQ61opTVg9IWX4ajmO4cuj8YSKiigmi1J?=
 =?us-ascii?Q?MXTZaLUXBs24A=3D=3D?=
X-Microsoft-Antispam-Message-Info: b5tZF8XSFUVoFq8aahg3oQHmgvI9hqYwFJS6JPthjZvM0uuHmq3AOphSt671kbiePFfDU5+b+W3+4Vl6OVbuOv4fUv5zrhOkbwRxM7WwQ4fVhIhta0XgLBM3OQXxQspzhXrrp9LqIam+Kb3TyfIMwyxyGCN6WSdttC5MA2XV8VeMl2aorrrUxcT5i7j+ps+mAhsicsiTE8IoVcbnch8SOa+OmiUK/XfVXrBK6saRUOFl0eC11Pmi+vJIzfJdgEk5KhCYOFbykscOPO9mv7PdRrruYqkasL2yjbKYyYJPyPRr3EB2rvTEuDaZ5Bne9QTUQrczvD7SltIsKiw0gLyt/lqMVo44KNuC0pZnv6lFAmQ=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;6:l9EqyucoHRDb+49NrthX7ngBWQ8G52EnEXPuwxudZcPyS2xmN31kIuLZkLnJlWxRGzCHlkLnOrONNuVF1ql2aph3dz2YC8lIpgLzGomx0N2URrILDQUr8gSbswnEZKI3uDrWlUoZIQfcFcFLtN+IpDh77ia+WnVAMWiXUWoDkQlvt+I3enAJhKw08FHmM6HbQVmvwVAJYdTs6WRs5MQIk8yUxePji4FoPHk4keNYMHYV9SSnoO+GjyolABey5TJvL7X9afxxPsh2F1v9t2+2OAmIWpi0PvgQ6zGXNHFUYFDm6M97lrvUtcNcRbeSGqgdACMNR/yiWipVlaB5rudMNxtRXAzHsC5dn9ZYogiXAQiyCOKUkrMbuoYFC3k0G2xjgqT9bDhh68Mf2T8C9Ml70tEIdeKAI7+c0Ie9cj6U1j6aviXwH81PM5/F5TTGCXhZEMnOFX9n+ghpVtWcQukulw==;5:EFZ1UNrqljqjGpfeFX2zlQyzltMsMy5D+aT9421Ul7rwcpsXynLv7cUm5tulwOKV74QKmDHGLpiWa52NWpHYCqdmMSdKC9AIt6IKJlfYjlDzr8E1Ukr3Y234+quKWMkuT54wGXfVzVFFILz1VwykdoYibpSG2OB/jYfrwa+K6jA=;24:LZ3O6nkUPTqcQMZzwqlXJFL0/uryYHT+eaZEZ4FOD170tuLvTvX0DRUoYy5nVEFnLHcqI1UmD8aY/ROMelXiTR9IOdMOxb9f+WpnHCaHmr0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB3262;7:twXBXzmHeZZPrY1gsnpodnB0ZfVYiWerMmjsAOsDZ2U6UFAoKlAmXGTAXgIPLJpNKCgCehFTDyvDqsYCZAzsLYgUgvYBkfwH+5vbDGcv+20XEp9sZB3xvPQ7zdx2oySjBLYWpfI3lzZWE29nys/mHN9rmiTfNB9Q0B9JnrQ+ngiJUoFn+/IlAKq1D5bRRpjMsQ1rIzW5AXxDewSGQXkVwz2wlOQa83LeF/+k79gcrZ7VcsCDASJFpznx4DO+c5q2
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 05:50:06.7547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f3dc0c-edca-427c-0d16-08d5dbf1d632
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 10:07:26AM +1000, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the rdma tree got a conflict in:
>
>   drivers/infiniband/core/uverbs_cmd.c
>
> between commit:
>
>   940efcc8889f ("RDMA/uverbs: Protect from attempts to create flows on unsupported QP")
>
> from the rdma-fixes tree and commit:
>
>   e99028ad76e7 ("RDMA/uverbs: Check existence of create_flow callback")
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
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/infiniband/core/uverbs_cmd.c
> index 87ffeebc0b28,5fc14fde274c..000000000000
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@@ -3559,11 -3554,11 +3554,16 @@@ int ib_uverbs_ex_create_flow(struct ib_
>   		goto err_uobj;
>   	}
>
>  +	if (qp->qp_type != IB_QPT_UD && qp->qp_type != IB_QPT_RAW_PACKET) {
>  +		err = -EINVAL;
>  +		goto err_put;
>  +	}
>  +
> + 	if (!qp->device->create_flow) {
> + 		err = -EOPNOTSUPP;
> + 		goto err_put;
> + 	}
> +

Thanks Stephen, looks good.

>   	flow_attr = kzalloc(struct_size(flow_attr, flows,
>   				cmd.flow_attr.num_of_specs), GFP_KERNEL);
>   	if (!flow_attr) {



--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbMyWJAAoJEORje4g2clinkT8P/ArcUH7f8+w+Z1u3JZa0K9Ib
sUX9gS4YDPl/Jkov/wVW8S/cwGLRyCvrN177r4/LOGMJri1l2V4PmP53Gutet9oI
bBbbdcJ9jvghW3acD+2lzGhddqe8mk6psmjPMh6qK4QP7B7/mO2NxcBUeF3hK8eU
lal2JbBcMsaLgGWsQ0UrrL4X3zWtLEPgawSwDQjn+dDcs9m6OL8a+Vm1Ayw3VHLU
wObpB+20f4fq7dCHKKSG2TvBvotptUNCh8QwdSxYipDWFEBBYJOcGfdSj4aI199/
aozp7hGTD8953VKTcHVnDQcczVE7iovzfd3mHNGVEV+Jy6VaJe2H+JZR9YTE1Vke
87SvtyTLQIgMwR3BHqBMtcrZglndzFEzQ3JRJHl1cOPZ4G002KyKld6A0YWP0Tsr
HADhhjUMpiu5PvGOaBzzl0PBprkFbhaouQvlAlhGosdNvi0wuG3pUsKJUzSvVWzn
TbvmvODagbDxpUI4wm8BJm5Mkn6JVcbXxpXuxXsdYJgxwICS4FvZpPDFVdaF8x0l
mNhjj/qwT0aEr1I2VpNLiXPIoVxQEFawAVhNKpZU37qd9GVE+ZyPUHc6vneM+AXf
JrFhcHiw9z1218gNYxSxCnMtDEQj3urnfzuqYzEsr7hqOLFkzPz2T4Y5Swd/8fKN
XcFskSwW60LlHM+hp4E0
=k306
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
