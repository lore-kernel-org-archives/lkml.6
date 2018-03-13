Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932796AbeCMKpW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:45:22 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:45312
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932566AbeCMKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:45:19 -0400
From: Petr Machata <petrm@mellanox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
References: <20180313112941.7971ba0c@canb.auug.org.au>
Date: Tue, 13 Mar 2018 12:41:46 +0200
In-Reply-To: <20180313112941.7971ba0c@canb.auug.org.au> (Stephen Rothwell's
        message of "Tue, 13 Mar 2018 11:29:41 +1100")
Message-ID: <wihtvtkjlzp.fsf@dev-r-vrt-156.mtr.labs.mlnx>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: AM5PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::34) To AM5PR0502MB3010.eurprd05.prod.outlook.com
 (2603:10a6:203:a1::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8896c3cc-ce70-4449-54b9-08d588cf827f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0502MB3010;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0502MB3010;3:fD2dOo4GdaQdsAz0f/WfPVYbG90NRZlUxZzn0+NkCKzmp3CK4fNkiFsqZ/wFMLcwFJRrGz2GhXbTV57y98l5rc/EM1ey4oOXTcss+3fYbeF9IgzdCOhuRByxZS1jFoQDmSB0p+cG8ZCvcJ7VWNBp8TH2As//Q5kvUMh8GKVvlGDuIEMI17yZCdCqOGBCF3wBHf/LAE5WLgrV/QvjBXO8hIr9G2vMdobkKLZf4nXm+zsJcgP7L+VRDHKejk2TcZOs;25:5ZT1LiZoE8QUHe3443ksntjoh80sMSgxoXyKonW/OmtWQtqo8mcJPCQU4peG6onP8KI9ZiVWNKhe3clXgCq4VI44KPfx8i6WXR7pnlu7vyTHHUSEcdYuEOE5dVa3x3tjBS3qdhuG8qX8/bhFCEBbbUYksxX78mkMnLGk26D9qCkAA8CMSg9AMM9/ihyLujbu3NlBnmHiDPifut9hk49Tr7ORnfheafwkf/ho7OZkfOAVelx6HC0bzweRf8c48EhbLlUjvHaFUx3qM7NbGrJWytxK6RuP6IdBr6989N6J94I/nzAe3A9oZvdnZKq8udTvV4RqxLeByvo9k0GECMcy4A==;31:XDy1GAS49j8BunXe6nG7dRpXGQpaPHJVxtSWNgXGPAXugoXvD/IA3uD7bZDbXOQM2rn0zrQQtUCvIEVdpMwgls26ks99o2XP9baT/0KYcSPn9JEzHrOfR1FXfmcWdIzHmoiBZ6rnmvEGvXRCcQeMyWROJI+B+IzwEjRDTrEtv7P6KHeFCk7+PDO0Ox74yG4YcjHuanFAiSpESzkDXKB2FjTYUkmNYgyezELKJ6ZM33M=
X-MS-TrafficTypeDiagnostic: AM5PR0502MB3010:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=petrm@mellanox.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0502MB3010;20:+ilYsMzuK8J9tjA0QvqoL1DJxecK4wgQDxp0JwUn4p7uXQOfNDGp3VJR/HDdm3BMZCMXnGy2obt/inEpho3S/1dwjnuCL+TNh0d+Qq7k0QGEqtnzr7pBQqkVooTWYoz5ENfAgslufB7p2MqmhLcUeBSJZ0cE8h22PxtM8QTK5dVyy8oOtOZWQtQ+gz8MlGQfIHAtZuBRTgdc9TI7EvRpIKavnZqI5kcAyKQA95N8t0jnmBS2bCvFQMpfQYtpl0hVbEej+nieJjjpfa7b2UDdiA3n4CUrTG4odN8kitBgjEZ9BYV9jtyDkHOoM3HYoGendSGwjQWgNeSVExQHFeNZVYlLV8hcrQdrg8q6Uq2bL4r88R+qNn3uPzkBRo11gazT67nuoa+GjueZYK1MkgtgtKMkrU+wtmAsNHia/AHmG2zKP9X+G8vxsJofowjodWzT6/czvxVxeWc4iZ03tYp5LS1rwmWxd9xC3zSQwdhodAdcsOHeKi47t/Sa7Zd+pk1t;4:EOhwd+FOcAIOdijrYDmtQJmchKZhYuBDc/56AqNGJm3A8A81wTMHoBxWmf7Cy0GVDKG4S8fKAz17u2CjoFa6xudxzPH7mIO7N3G58nj0Uub6VAEUrWouQXs79pFP6YphA3OGSxt3m09gOz9pNJ+0ho8alwcRkLCEGx7RCEUo/TVY5cZiuYeTYiXMZttylVnm7NdukYiS98Rg0enl3O93uIjeGQfnRpyLEK3HM2BnEncDMnlRJrTQgW8KrrE3+haLyxoXu7bxQw+NFAyqvRFr0A==
X-Microsoft-Antispam-PRVS: <AM5PR0502MB3010FD098983FE64922B1AEDDBD20@AM5PR0502MB3010.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0502MB3010;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0502MB3010;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(39380400002)(366004)(396003)(199004)(189003)(3846002)(7696005)(8936002)(16586007)(8676002)(26005)(305945005)(316002)(81156014)(58126008)(81166006)(7736002)(54906003)(6916009)(16526019)(51416003)(52116002)(48376002)(2950100002)(97736004)(6116002)(105586002)(229853002)(6666003)(386003)(6506007)(68736007)(55016002)(86362001)(106356001)(478600001)(53936002)(76176011)(50466002)(66066001)(9686003)(6246003)(4326008)(25786009)(47776003)(2906002)(107886003)(5660300001)(4226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0502MB3010;H:dev-r-vrt-156.mtr.labs.mlnx;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0502MB3010;23:xl6RP6+iMNQc46e+NIOkZy/0oxZwdIHuyifxL1G?=
 =?us-ascii?Q?GkUooXA+LBng6JtXDcWFs7tQm4lBPUM2B6iLmnAQJChcD/I6+NoCnNLzVB0V?=
 =?us-ascii?Q?Ly3Dx5hS2ebIpFiA8mbClb3HoDs81uFsxzmuygEBUltfEUQ3MX6Y0qDiFLH/?=
 =?us-ascii?Q?Q79YSvkyrrVoYJpOAKE2RIUiWWq4dpdRLLXOflLc8jhH5R3Yjwl9AD/FS1xH?=
 =?us-ascii?Q?PrhxIvhH737W7VWrv/McSvRtmhtB5SQQv4YIC4UcAPxGblNzLPGkLGbUBggX?=
 =?us-ascii?Q?8q9Vhdvi8BBAlY1r6GWfFdGqI6GsPGqXMff0992dA7DKFoLL/AtYWr522sGz?=
 =?us-ascii?Q?3I/AdAvc3tzJZboxMlvosmtJuhFWR8iXQaKZDF9OZox8qBkKs/oqPeJxLXwn?=
 =?us-ascii?Q?oGSuWeRE5mkbUDIyw6FcFGzdLAzLZPyDvdYUOBrIrOQbyiFypmV+3s2GZbcL?=
 =?us-ascii?Q?k5DRPxQmHhOjdmyhK5WnWFn/Hxgd1cHg8ikB2D/eP/eQubzhO4hfj0Y/u3Sv?=
 =?us-ascii?Q?AVFKj7t13ZK/BhrgkRravFio/1KBjHiclG0rxFhdfU6PIFjBvDxH3jL8HJcJ?=
 =?us-ascii?Q?S3AFgH9p0j/+YjiC7k3Fq0pN8QeiVur7uF66d6nHpXhFpx28CFRI4V9kWw0d?=
 =?us-ascii?Q?xQR/qeaU9r7ZYO4R1PkwUEUvo4Dzp3Ujkza/S7ov28UmJ7XXgkO09oY1pbtp?=
 =?us-ascii?Q?kg/tEjBdPOUKYSyffgEFQzs5YKtZ8Ud0805CbcLhYpOq6SH+E3yWZb9/+9Bo?=
 =?us-ascii?Q?msN1lH7buesAzJy1Ocj3jiy3yJpUJfpxgIC0fQN73nXJscbTO+86QLMCWJkt?=
 =?us-ascii?Q?bQZxezczcCrFCgOKLhBG4xHAXomCDSA9GuVdG3YnxIZu08bF+o6gPBzqdMfO?=
 =?us-ascii?Q?WnaPpeUb7s0IwAUdGZzRRg/rMMyPSkI+LRY4fyv+YDeLbN5mXMgBh9Ev2UWQ?=
 =?us-ascii?Q?Lf/awgulFBsSEcVqlEtxa7H7vBbyq8lgVTu2EcEdoEhHBvFm7qLsCpkDdQL6?=
 =?us-ascii?Q?Bp6tv2cBTQtCTp8ZO0yykGjncOR6w83D9SyMuU6Ge6Ey1wdMThKAbeQLI5hW?=
 =?us-ascii?Q?CrTAc+eOov84g7DAtMwnl61Hdkcz3MUnPx5w6hvc2K8qPuoY3iHuBmDDORnB?=
 =?us-ascii?Q?eWKetkDDXGOlE69AyIkCC/z2LwG/moGDF7n3lr/0QPoj702dVXZIM7jHMBOH?=
 =?us-ascii?Q?OTEMfWW2dYMnSd5U=3D?=
X-Microsoft-Antispam-Message-Info: QE/nuh31+imiD/wEDbBN0pK9TnbvTMx6kMjgOHW5jBvN9wecJ9gRL9okP1RU1VeWO62oWxhb9KD3miS9i7jYeUDPGajZumYUz5iuX6JCpzZX1KPh8z69Rmwz29t5Cw1oby7ElLgZoU5s2gO4iUqZCReXeThE2nnXazMocpbAeWry48y41hNClLb8G/CbGfV4
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0502MB3010;6:wFVl5RYDhpvRXcWeuKAF3U+o4/KZgskco05xXeAIajNqPJdaiReqNhYnDTl4eTwa9/SP0vv1HSnsg33qrmZhNSBvCQaRNFMKjuBYdlLgwbaqrRx7o2MxtqgD457L+6TiyBssEauXsHyVqsf7bVBZzoSb8rJar1/hz2EjpYK0x5jmltHOFPPJAAXYTj7QTJTp7Z3n2P60BAcvtjmcV6hiYR69B1GkQXPflVxZWPZf3wXwdUyXDR6RA1pKCV581xBVom7tbM3vYw9XMGmSfJa0wruapXFYEDeIYZ1kU74kLps67wfLiwbr4w0dj2Uooa/MMMhcP4vGxCtzEe4IRqi+LSKznjuC9uCMjaVPzSVEwzA=;5:27X5Vwj/wW5nwdIeqnIQyNuZRm+alSZqmU6+ip+e5tkNLGQfuRJu2j8YyLfqe9zj/ySdEcFfAPlU0+pg46N1QalhFkC/0fQC4/HbJu4CzOsqXxEoRuTIyDhb5YmgeaX17hNcvrlmU5D8TTBBYHinLi9vsoqvf+2Ff0tPk6t+G4g=;24:k2a22d6PYS06weHfGgAnNtKu6g2lKSsVU+ymx9oRk8wuPhFyG4u33hcZtWrarDM2kzpOR6GdVdxkACFY4KGjN5Ra6/pC5jX0DqPIsJsHLG4=;7:3dQ32yStBPzUJBZCFC+l1Pr8R6Zyio1nuI3RNjpMVZbLQ1WWVlEerLpIX+rGzVAOdS55t73r4LWd6DXL8z31SkCuHI+L+OMYIBne0PFSGK+2U6BQwYOlZ8XirTuobnlQ7YRFxq+7t+qQTjZjmAS+/aZyZZ3KQnELFSfLdumOFVTYFiHjm1MS7cVRhFOXixUO5NnIKdalHgHFKmCWpfp41VNXbHOCLaWgfmsWnTqO+sm8CQVhopaQfksXKNZY/mMd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 10:45:16.1315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8896c3cc-ce70-4449-54b9-08d588cf827f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0502MB3010
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Today's linux-next merge of the net-next tree got conflicts in:
>
>   drivers/net/ethernet/mellanox/mlxsw/spectrum.h
>   drivers/net/ethernet/mellanox/mlxsw/spectrum.c
>
> between commit:
>
>   663f1b26f9c1 ("mlxsw: spectrum: Prevent duplicate mirrors")
>
> from the net tree and commit:
>
>   a629ef210d89 ("mlxsw: spectrum: Move SPAN code to separate module")
>
> from the net-next tree.
>
> I fixed it up

Looks good.

Thanks,
Petr
