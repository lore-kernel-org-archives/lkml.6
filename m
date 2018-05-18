Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbeERIka (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:40:30 -0400
Received: from mail-cys01nam02on0064.outbound.protection.outlook.com ([104.47.37.64]:5310
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751750AbeERIkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:40:25 -0400
Authentication-Results: spf=pass (sender IP is 208.19.99.223)
 smtp.mailfrom=microsemi.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=microsemi.com;
Date: Fri, 18 May 2018 10:38:00 +0200
From: "Allan W. Nielsen" <allan.nielsen@microsemi.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: "David S . Miller" <davem@davemloft.net>, <razvan.stefanescu@nxp.com>,
        <po.liu@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Andrew Lunn" <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next ] net: mscc: Add SPDX identifier
Message-ID: <20180518083800.GC11206@microsemi.com>
References: <20180517192305.17517-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20180517192305.17517-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:208.19.99.223;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(39380400002)(2980300002)(438002)(189003)(199004)(6666003)(97736004)(8936002)(81166006)(5660300001)(81156014)(6916009)(86362001)(36756003)(69596002)(478600001)(33656002)(336012)(1076002)(68736007)(229853002)(72206003)(57986006)(2906002)(476003)(446003)(11346002)(77096007)(126002)(186003)(26005)(2616005)(76506005)(59450400001)(106466001)(8676002)(76176011)(356003)(305945005)(4326008)(39060400002)(316002)(16586007)(8656006)(23756003)(53936002)(50466002)(53546011)(486006)(106002)(47776003)(6246003)(58126008)(54906003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1395;H:AUSMBX3.microsemi.net;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD016;1:spS5VM/G/vGKN6BF6Z6DaqwRPP/ozqk5tgVl/27s5hrID21jS5DZVbsfByY67ANm3rfBxxMm6+/u0anA11JHciKYLGq8N1OCFLIxkaUsJj1Q9Klt/bpTQuYE/uf+uQ4P
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR02MB1395;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1395;3:bjxVQfdPU1Ymb3aanBIf6emF+bpqeaWc9nMCuHLQRUTBihqu/amhL7gpTvGcS7dS9KlomCYcSpjZgIuQGwHk1JUYytRv5xaC2oX79lGtwxU+GUU0KNTByb3o2GY0+KQ2qWhHcSYgyhv10AP48iB6yaKS3xIU3XRcq23qrZcXtqdCSTN+I3ehehs71Y0OFta80iVREEcO6UnPHQHlNz9N7dl47fY3xq9SuE2nZtfyKsW56/kyzB0WuZe5KSRWRoSucL13KTWJOmOHYWMFClNUhDLddjlSNLbvNyAXA+PCCfoKF4HSqzqEcwUTi/ZpVRiG96fhHEvpa3A5zPAkg5iBUqERQB6ljFbgwdJOZneqhTQ=;25:y5A2VXnE/ojeuyjVy7jbb7Sh89JruRYq2T4i+SP3H927fX34XQ8clBGmDghgcWWKOj7Dcz/E3rw9N8d1NgaCf44FLGhYa/+8yCew9qHa1WmxxQfHKz/5DK/a2LBjWzAjLLogiXDwhaQn6fWNOAnhfNRYbSBOBJ7qylVqWMiRTUdt+CtwgtN6j5aRA5GUFuVMwMRBOi3xC3QncBaIeZw7KYlYVZhXddWmbXbN/WNB6cFpgac71gCblIQtVmq1AzUo/ljjpB/xqbcHMZgvqJ4IakXIGGiyEbLOc5jN4yU642IwKppgVA6NEBGVULOC0Km9FYfxonIIvG/2lqNAr5MNrQ==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1395:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1395;31:yWnJ6GQOgYMfF1G4V736MGdzuy0YKjp9Q+nhkzhmoHengDut0NJeSnvbJZQvpeCgqk4jzbtL9bYn46XWNt+T9sut9gk0/JGvVpCJ8gNpFVOPtgUjeQQffm4zWUqj5EAU0E8S3AV8LeOn+LPhgkXOt9ZLspA7BsqnvfE3n5AyHCKIYFzdW0yM+rgM+zanIES1KTdQWWwqNYGWpzdEXB8WUcM/WahjzrWBUDlhlOy+fX4=;20:Tn8mb9Y4IYjuj1oB0z1v1uubksUnhnx/4FZ3ZQ68Nqj14MBGdu5JBm75T9Qy7Hlmbia5V0u6/OiU7rmvT/Do8LJ+bXRF2UgdP6XIKAtkQdjIq8kYt8ysQFmHh5naoF3TMBSEuww9fv897mn8MWdzQ5VtZcisjSYFDt2Yz/Fftfvrx0S9LEirXlgPmILrYvYsjWDqqStTXeTx6wf9FgGlB2VTTU1dptlFNOKbp0uFuY0te9/nYkWiU4xC/HcNAL7IXjCKgFzftlgooOCQNfTBsHbuSV4BK0LtGn1l14JFu6G/zl5CIf1CsDYvSgzbC+RdPssy/sQjaca4rRKBIbNU4fqD/Ezuc/Th6dBFfppuVvp8bu2xySna9Vyp6/fjrSidJoK8bJPfTgjpA4qYX4PEa9ZL70p7ibDK6/ydmVe3YXxPsWo4fLhdynCcm5WSYsEsqNS7zNA/xo90KDFTKgaxsELtgeoTDFa8J0EYzeor5BtKMpRxJlyehkBii/okVl6h
X-Microsoft-Antispam-PRVS: <BY2PR02MB1395E4881899F4F46DE627E8EB900@BY2PR02MB1395.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170198267865);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB1395;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1395;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1395;4:jZgAq9cLDwm1bLtjD3Zvmfi/u7VKhdZeb4Rl66m1Xrw+/UdH52UUZrOZdJCEkIlFOUlfJNBalAGmDE2EiBA5ZtZyMP5BMXZIz6HBiuLqsj9HMYFGKvY3uIV1eDzqsHeLHzRflT1XYqxD+dUdNF25uNQYXvM1YkCUV2TviwtZz1i223QYfxwByxQBbDEi93bfOKRBoug6h8tlmMbzAwQraPV4HfKnfn3pAxvcoDZ+TIyUdYKbVQlA2kSo2pNnhF7bN8bg5azlC8elR2qbVcE+KwWTAQr1v6BsuOOUn4b71mlaKPltifAcOL/GPotjatpp
X-Forefront-PRVS: 0676F530A9
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BY2PR02MB1395;23:MTRRLAAkgu32TrJcI0Rym/B4SmgGXnQ3aATZe/D?=
 =?iso-8859-1?Q?afsMWACjHV0Tvd74KZfOwBBX79W4Or5CUh5o+3FoBn+81YUfbTUH5Y4Sb+?=
 =?iso-8859-1?Q?Bf9rmTO0sSjfjUumx3ytM3zdQaCyU32Hyrxy7rHMaGUVAHAjQkX+j2zvyC?=
 =?iso-8859-1?Q?rvWBbOPVEULRbpZEZMRZXwoTfw4xbjHhojSjk+cL4q+8CzULwJyZKMS4Qm?=
 =?iso-8859-1?Q?4lAvZoVr1Q60in+UGEhxljc5Gjt0mth8zbh4GLPY8rZ8oRbIg4BaC/ViDS?=
 =?iso-8859-1?Q?Yrn3pZ6BDVkvhaq4kZ0SuctI85YLJF1ByVCbGWaE12YkdSRW+LFSDGe9g2?=
 =?iso-8859-1?Q?XkKxFn0JOOyeVewvamBCk49iJuqGxOg08GMgh3F22GUjxqbojMetMr2z2R?=
 =?iso-8859-1?Q?isaLhcpgOkUgLTmFrOgbo7NFMNheotnJKsMp/UibvpSvs8EJnG5ywcN0s7?=
 =?iso-8859-1?Q?IkFjx8neBdEuSqGXRfST7cMFo7F0ntf5jWIMi+Sduq8KEUZ5tk7GMQpW9t?=
 =?iso-8859-1?Q?ibAeNKF7Jo0Jkt1rBV+L/fuUwO6+1HcUTRcLBGkxz5D2A1dL2smhAbDycs?=
 =?iso-8859-1?Q?rXk9u8Wv5376KBiZoFN6WpezZZmx2Rpt8bhK4s0IfIhRcJOXl0KIc/UTZH?=
 =?iso-8859-1?Q?xVaJYhwbdsEegbLB0qqWqbZIg4Toz06AzYco/xQ+F4+L19o3dL+Dp6WQ9m?=
 =?iso-8859-1?Q?9UOr9EcZlWAIprdsfp66YR2sF247zXfnaa07qt0XpQ5CZvkFdExVNRIxGT?=
 =?iso-8859-1?Q?RjiDxhAjRvnBcNBPPZOmgcMHkpwZNgs4fycw+BO1I8LEqPgnXHyRSXr+1q?=
 =?iso-8859-1?Q?TS1pM26JbBtFFKCAf+ZbQCRIpaLTzS6fHoeubO/thjlFvcnGol3VJ6tW/V?=
 =?iso-8859-1?Q?Z/7mkLeKsKhUVauds612qtBdTNmjo8N7aa1U5sBEJMMYLIf8OlncRaCjMo?=
 =?iso-8859-1?Q?keUku8zLmK94ap0fMALrD9QlZ8ORIFqL5zPHL6lOIRHqYEsQRlSfbeRMxg?=
 =?iso-8859-1?Q?rK5K3EELmWpg2cphQ9fj+tjaC88wDwncySVR2kKdimoo/IcShRx+GaGhEZ?=
 =?iso-8859-1?Q?+H/ckOzgl89UFC3hwJUICeQdVj09FcQHr3mPXuOCr0sIZJX/brZqbpmBbo?=
 =?iso-8859-1?Q?oRX5xmqV5X2xQr6w4DezEqWSvv7L5THgkCEknUEJJXwgLxK/CJnch2UD6j?=
 =?iso-8859-1?Q?8jobmDeBdt+4AQ7r8JZSVY9MiKIss5eesqGcr80LnjFJbh4Ga9zRIFi6b9?=
 =?iso-8859-1?Q?cUPlh9vCD8nHzwDIV/eohBCfsjPZXjPujyRONBB72u80BsGnELuJ+f4XCh?=
 =?iso-8859-1?Q?EkuWk7oYv5Vntba/V6kdtdEQYFzi3vqtHjhiyAd5zFa8uPmTicMP1sSTA9?=
 =?iso-8859-1?Q?ABM3p+nCl8bKNfDYM3vkaJwDAVIqz?=
X-Microsoft-Antispam-Message-Info: IE9576MFRrcRWc62O1jHc3VsK3+UmgYpyw2GaBY18cH5yoYkQh8R7lV2czEtVbTsrVf0LXasB4BcK1YDNi6oXaK+yCtIepyP7KmB9ILBVLlLWUEMtK1+g4AFcuR3PMSM4lEt+JcpvatCumZq5/a77IU3tGwUK0Mwo3qhF6xsVaNe3O8VbLCBykHzhLQ8e5E+
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1395;6:4lc+WclUqQsmgScFeiMam2C/XR9EYBmVDeiWAvQBospotJbASu2GPHVVOo1X+XzMwYjCtpuyLziLNLvEXxLgtZ9R5IxOsHs/6gZa+rX53uYwkLf8xiz1iy8IrTpuYvlUfbh9ViONG4E+g/hnAApoyHSDqDFIjBrz2wg9yhueZsFj1lBQrNJm1E4WlaiDPOvc4YEXMHeU3TPpHOY6Qj/7kMjMhviGbjVTG62SC8PvUpeDrEEGYUQW8Jw3jJr71qe9qrF6523+Xd9x08pKEbPCr2Mz7sDVDYEANqjqat6Iby63/cv5FEBr0GtKJwaY3roIKd2DDpKn5guMQHg2z1lbcFO1IPWSptXxO+4qtFaz6eBHr4d1GVZ21Ctooyi10N0qD5U35KMKN7qTxTkmgMpKuZr+KzmHt2ZNWN/yG6/f06CBKPENdWtEkMaq2ei4VoAZqmzPq1fTMPjdm2mDTY4V9w==;5:kIN3We7r2xRqSTh+mSR75ZtkVS3zcghJ1n0H8veQokeWuNIn2AplvsqzyaKW3U8dRvGqNgc+8pd2IBGClfNTEK9AqDoepD/zdwUlClCXOFegmVTmJNKXmeAayEfwBJipxqkNNvUJCCWUAXqA5BvyMgM9D02eEtMDOPz+r11S96U=;24:AlRqagQtXuiXyboSmdE0xBkbD/Pocnmx0RTtDde8l6GJrvGKHKLWgGmgpe3qhuLc4joSQYFnmd6b2PyOpFh/zq+NfEoaJoZA3b/z3oWaJSA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1395;7:6J3enKYvt5+Q64/8O19n19B8nbhsCmJlcoGTh/28wqUYQJnV0l2wvD6M6RiPaHZquKfz/d7mjNfVgGZYDng1wwkYeqPWxwtSeR0QCd8j7i9NEe1GhPFuRJ5VM3yG3pfzlsK7qCs9I739Q6GoI3jPaJJhue5M/AmXweiKmNxtDujpsbrTsjkoRstYzmFpk9f+J7KfROor+r20TJ5OyCJ2MyvGX6K8x/VYdeBFxT5mjnowIAKn0QDjuyRcKbDdNR7X
X-MS-Office365-Filtering-Correlation-Id: 9c6841f3-bad1-4d49-8765-08d5bc9afec9
X-OriginatorOrg: microsemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:40:22.6994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6841f3-bad1-4d49-8765-08d5bc9afec9
X-MS-Exchange-CrossTenant-Id: f267a5c8-86d8-4cc9-af71-1fd2c67c8fad
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f267a5c8-86d8-4cc9-af71-1fd2c67c8fad;Ip=[208.19.99.223];Helo=[AUSMBX3.microsemi.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1395
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/18 21:23, Alexandre Belloni wrote:
> ocelot_qsys.h is missing the SPDX identfier, fix that.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/net/ethernet/mscc/ocelot_qsys.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot_qsys.h b/drivers/net/ethernet/mscc/ocelot_qsys.h
> index aa7267d5ca77..d8c63aa761be 100644
> --- a/drivers/net/ethernet/mscc/ocelot_qsys.h
> +++ b/drivers/net/ethernet/mscc/ocelot_qsys.h
> @@ -1,7 +1,7 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>  /*
>   * Microsemi Ocelot Switch driver
>   *
> - * License: Dual MIT/GPL
>   * Copyright (c) 2017 Microsemi Corporation
>   */
> 
> --
> 2.17.0
> 

Reviewed-by: Allan W. Nielsen <allan.nielsen@microsemi.com>
