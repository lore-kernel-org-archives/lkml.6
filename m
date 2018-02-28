Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeB1JrH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:47:07 -0500
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:50394
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751126AbeB1JrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:47:04 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=petrm@mellanox.com;
From: Petr Machata <petrm@mellanox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>,
        Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
References: <20180228095628.4a2f35c2@canb.auug.org.au>
Date: Wed, 28 Feb 2018 11:46:44 +0200
In-Reply-To: <20180228095628.4a2f35c2@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 28 Feb 2018 09:56:28 +1100")
Message-ID: <wihsh9lmoor.fsf@dev-r-vrt-156.mtr.labs.mlnx>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0102CA0106.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::47) To VI1PR0502MB3022.eurprd05.prod.outlook.com
 (2603:10a6:800:b3::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13c6461b-d5a1-406d-2c63-08d57e903764
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0502MB3022;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3022;3:kceceUetWvNooXD5QPfaL4twBaDoLFTeUNsVPxybeK/MMQXZK/JuNpJGJjAEO+6BdyCZ+gGI+iewE6/2dM1Xqg7X/NTuWl6ksSBFYPWpLFIfwLdOMMMiJculslzm/amqwEiFSyGx5PyeG55faml+bttV+l6nhHcaQXcf79TRSLHbBdONrR2+iFLM6HUDl8SOauB05zOl/trCfQkRIfKdV1A5L9YllWKyV78g8PCRhUly8uXK3jQLAG4mSIGhH5W+;25:MEw2E2MjeGwX9/luKmWqjcM3VWWYtkBxUqxbbFysM3jMHfb1LZ5JOrb12OrmK/nG5I8wDrDTX6pC82/dgHOvVg31ggZjX7oGxFceOFxD+ZPUnvH+INWjmNGkvBd62aZW/bbVQl6+yBD7IJVqtiLveiMJYKDvtEuSstRKlEsQiSd0t1ueB1T1nO0dcsJMjqd7JUyYzDnpieTVzAkZXT8Oh+anCZupHv0HP53fpR5WKOrMFgzW81JJFn/pZL7X+k4SiL8RvIQ0w3FVUimVwi2Gj1HMOvOzjW7QICu8u0Zu3nEzrHTgRttvW3CXWwQgXjCR6UpJ/kCpoereF9dIiJQ0PQ==;31:8inRjdvAmQVAlBjuK3O62StRF4aVzno4PzJgFc547/tasgwDqQKpruDa04OMVCqtlrC0xpcU1T/1VfDFtmsBx7ew2xJ20/MvpuRDM+r9qFRELkzqDhOcStCHw07AGzB4y0yAWgg1OWH6lnWo1DxaKXs0WCitzvRuuX60u68aQe+8gPQCCoIVOtIUXT+jR2OwKYuKZXAHwaEBK8zEVgAkiyALA1+qbxkZAAF4bZEyWV8=
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3022:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3022;20:fhBMEe8hEh2nLCZ1fAT0R5lIWwPfWD++sAa8I1wiswl8Wph6wwmRYMopAmZQsOKSKtE+w4iE7bwn+5gAQDMQe5Qx+FEdda5Z6vi9vCUMVVNK4Nj12JAn/4Px7kWbU+pESCv2mHDsmoS22O0u9kzzCx3TmSEPF5xR11dWTouzLXU9PnauXtuHL6aJdxnqaghELUkmaWZIQoQyYJhs3u+QBPeHVi3gv2Xc1vAexFQTWlkJU5S1mbciprzM60HlMIyVyqcbHmwOe2KZHxoC9jswZ4Zs7yAzA38aNhMHAVTy7m98BqC+sBrg3UR0Jo6jo7a3GR/n7eBauQRIBxiimqd5GYlNN6GVIg3v0xzTUIa5fzNb+n1ehcpSbyIgl7EN49dLgpuaB2ZUdQmanXkCcy/TA/aur889pqgaxD8TW6N3nZCJ5kP4OYNWxMASB9uAyWwDXV6nqj5oozfi/73PrCIGbtIxOClQoWGMpE6aj0cSZI9Uj2+WpH2d3euzl18aD17D;4:0BDow4ChYl3dlmR6pvdqw7LYoXXJq6lrBCaGFk3RT9ZskialrIcZY8aKDkPKpCPi/nDFOdcw7FJTAM55jtZyS8+MlMNNF3LgeiXtllIYgDaR/6zmUnv8ceKF8TZkAVfBxcr/oPXMg8Hj6/L9rBKVUSMx86sfJ3s9L+VUppNHvVFw2vkSic/qnt5uWwQtVwHBZM5UKfPXj4bKuJno7fCbEycS4t6rw20MwvBrWlLOvMe0lorYe9yVkdkBfUR1om0xVjb270lztcV2+ZRv2rrpqw==
X-Microsoft-Antispam-PRVS: <VI1PR0502MB302251161F8C87B582D0B5E0DBC70@VI1PR0502MB3022.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501217)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0502MB3022;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3022;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(366004)(39380400002)(189003)(199004)(6666003)(7696005)(51416003)(52116002)(106356001)(7736002)(66066001)(8676002)(16586007)(50466002)(48376002)(2950100002)(229853002)(386003)(6916009)(316002)(81166006)(76176011)(8936002)(5660300001)(81156014)(26005)(16526019)(6506007)(53936002)(305945005)(6116002)(58126008)(3846002)(2906002)(9686003)(25786009)(54906003)(105586002)(55016002)(6246003)(47776003)(478600001)(4326008)(107886003)(86362001)(97736004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3022;H:dev-r-vrt-156.mtr.labs.mlnx;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0502MB3022;23:4zTLiRHhNGFv5EMEIbzSS5AEpqR7YvGopxWFMnK?=
 =?us-ascii?Q?wsfU6pdINvQrbubFcKfW4kUnWCMLM6pOLkwPejHIjVFcpbsna1zviCsr7JXa?=
 =?us-ascii?Q?MWUdohoRxhhDTvqWrEMkhvryL/tFkVTrYS+6qxT8fOGfrqVYYcZcIGYIR2NB?=
 =?us-ascii?Q?EEfsiXIVvQaJjQwMzyPR2fXtDzFL4BxM83enebLD9mNRuT0qOtpo/yhHUTFK?=
 =?us-ascii?Q?BLuqJgUWEPlVbkmwejqSsNVHrEkoOa9E5pnwZmM8jbrqdrjQDlb5Uw1TbezO?=
 =?us-ascii?Q?Kga88G6NH3Q34Ydj2RR/VR5Msb9LXCzSeUqeexz6wAbTLImuERD5pIJNh3ZP?=
 =?us-ascii?Q?Ddq7VaLVHIL15sqes2OpkKwiAMmkyOBDnfvJs1KZU/bTBVykc1VXSZBrh5Dj?=
 =?us-ascii?Q?MmE3Gdn9gkWGjPrBo+5vPuQIQqb5D1RsEQMAdCw9IPbQZkJ+fEPJ/vhNRxZ9?=
 =?us-ascii?Q?AyIBeOM3Q5XxUlJR/wUHtViQB2MnkDR8ajVy7ipG8tVcP2WIL4nCwrSLebkM?=
 =?us-ascii?Q?PRyRDHY81fjoqle0MNhJN5aLELZhZn+3wgOKdPBHU8IZtg+e60gXM0Gtdg+9?=
 =?us-ascii?Q?/NHEkKY4AOfSqrXyMS/ykOrcBVLedcXn6KbVttHA9aL1xK1OozVeO7vpRhWa?=
 =?us-ascii?Q?Fs2Ct/iUf3w8SewZVn7AwsrfJFoB9iW9aiq7q7YzLPAjjvSv0ArLHOE7c0QN?=
 =?us-ascii?Q?ML6IPbT8T78mHnvn626ApqdU136h+AYfwgQU41nWsQ/2TUtKHIiEZcVXQIH5?=
 =?us-ascii?Q?lwQxRN+1dQw1CqEIvvJ/NU18OhQRa3L7rC1t6ZHHwwcfo4VhOtzn1BTTohsb?=
 =?us-ascii?Q?Ybct4NxtyPPnj/B0lYUHx0wVm2lMHSUKIuQUyUuEmE5DTYJ3lDbMcW1bMqN3?=
 =?us-ascii?Q?4StAmc28AAflKiWiDQBNpgVFm0MlykOUVhfOcdonbuDeH1tSTqGWV+YlQCtk?=
 =?us-ascii?Q?XgO6M34wfCa6XiCbidq83/ZGdiHf50XAJIiqtAMXEMaTb5KxV3D4RA2PeGl8?=
 =?us-ascii?Q?3C3/yB7v8J3LatQq3YJuQSrTPG1JDZkpNo5cAdNDYaeXhhjBWF/g17ZuF78U?=
 =?us-ascii?Q?ePGyX/Qm+CD7uUtE3JhDdvtYGR9BNNQ0K9Ei8Koprf/PP3ookEgmLzS7MILo?=
 =?us-ascii?Q?mOJFPSjdeBVQaX1p6FfNSSI6V4GaFcBhSMps3h+TdvZIEu2IzurngNQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3022;6:HtmviGlo9bddf8TPhj0ROalQ5oyB6OLG/TqYxmMtdemqX3mBAQN1jN3zqPq8XaXrLDtAW0mjnvuRGtyhkEUdXjkMs7lBw+Z2Mikj8OwEnDFMVjIrhiTezWK6qko/CHEpKJXPmmH2jE4Jbepn9Sjvo5IutRkHthTMJa3Jd6ECmsUO/GpBd9/oZGpWsT5c6C+4x9CkEPhPq9m8eJdYFN/VT+gDgUKyWQ0gkqoambkJT+DVDDOytfEc/RgHDWqZnL5eJTsfaOEvcEQ98WdeCRfRwLmSBiW0lLf9kfCDmVTyJTY2WFXiHJxOF9g+XO+tJc3SnRxVFd+dhNKq6Mbh3BaArX5QNX7FvP6U4OzckjZmWbM=;5:jAPBVzgNETtEadYRWL4ailejvcYsPeFga5swWlhupm8iESS4Iee3mvbM3WFG3IpyjftBoLhz91y6SkNWNsBhnHgM9oywN3i7xfocH8r8P+uNxwCJO10DryPQbj8+22xA0uCXEESaQzaruG041wdvB3NgZ9ZYvaWDrxIEKv5CylQ=;24:T0X9qwBc/rd57Wrq8JjVbIsnyA97INC5MQIGpGz0HPwHgbDWh3YKmcNxnq5tIYgpyBrM77DRs1k2eENwG3e68XqUTh6E4IfeVRRgiZmjARU=;7:twjf6lRqxb2n42K0CoGjTBWbfYX2xxPmJdeOX8FrN9g/XRZtIP0efPZ4d/m973XW5ITscfMCZ9NNgREhlywZMLwHkQmq4mXWF3bATOJcYa9ohoXZK2neOGTbdnHO6IMgoumQcpfv/IxO3d4f77spDU0FGIE+2y0FZNuUdLMfwRFrHLjtcHw0qnLjIjxHGW0D0zLCM5khl1xdkQMh4Fv0+yerGheuvLZPqQTmmnAqNkSI+zeyL7SYpxsLqU/VmAsy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 09:47:00.0620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c6461b-d5a1-406d-2c63-08d57e903764
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3022
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Today's linux-next merge of the net-next tree got a conflict in:
>
>   net/ipv4/ip_tunnel.c
>
> between commit:
>
>   4e994776e7bd ("ip_tunnel: Do not use mark in skb by default")
>
> from the net tree and commit:
>
>   b0066da52ea5 ("ip_tunnel: Rename & publish init_tunnel_flow")
>
> from the net-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary.

Looks good, thanks!

Petr
