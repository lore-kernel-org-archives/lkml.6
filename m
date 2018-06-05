Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbeFENXY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:23:24 -0400
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:63808
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751820AbeFENXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:23:21 -0400
Subject: Re: [PATCH v1] AMD SSB bits.
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBfwQTAQIAKQUCVo1liQIbIwUJCWYBgAcL
 CQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEN7/muRPME1TTfQP/A8U028LCMsxhCmg8KnL
 oaXk5iRhiS8bhQILSWS0wTGjnpyYIsOdL4TwLLMfFkCtSjsdQSOnu8RVP3nu1waC/6U2pWWS
 W26B4GwpHfq/mi/PZOBW6+tt0srwxVvuFNVN/uE5r7Girlc8QHQfNyYxZu4eTbl7MuIIwuys
 rCueJGgaDOGps7aeknQhSYIBsdV2CazuEa2T7v4KTsjNbHCesayUbl87tZoBcs5Cf1yeUjK6
 ePSVZPszEQ9Z5iE7meU3+COIQZPvEhaYDx5qpHZjakWpb0AfOspIxgxRR3W+sutOKshbdNDy
 IhbYc9xDjOWooI+6lkNKIdAyqoqq387JndjUuXVYPM3lNY5MVprH8bO1CUzusuMFSB8SlMKq
 p2sUEiS3jBpSd5C3GKxYAOkhTZn1kyNB7CyBVU2R4II1R0aSJf2yxOmWrEboeFO/SZQAX5ji
 A7obQE44zVZlSIlFh/sm7ns2zxJYyafML5N9CA+5RWJ2QQUzzjgZkvTc2lBwvl+kAe5P23aS
 aWbJdEgjV6jwhzHfKtlIznqk/t0quVwEzhzfvzxK/8HL+di2aeg5YxPA7VrjDRLFRGiCUgV9
 gAPlLR92LnUM3XUgdtCAlQ0xPY1qaxbqZcK04zGQu6HtcO7czIwLf5K/pjwQRlMxPIUDFcTx
 gl81owVskfEp6Y76zsFNBFaNZYkBEAC+8m2NNYbxIOqTodhtUPv2VpsoovMYUNLD47xF1m+T
 FryIe0cQ/VeWb9eOBLWyAAbUdE8LO8Qzm3u226/Z5UsWT7q/iQ7BZrcsIJHe+/BtJw7d4u7M
 6s3EDznEdN1O1zw0wSVw6TcFVfi/Mb8eYLK9iG4YgUHfYl/JGqeZNyOsHwUmZtWYFhkG9pm4
 rqjgz838zXSq/zArcVhLFjgH/wpRXMq/nPxIdvoF4AuSnodmSG/8TvtQq0wt0oPZfR7OQxtw
 qZQm1Slpmi9cu5nQokrdm/3VxNCtZyUfWckRjpX8GcNWhTx0/gMuaeq2Rs2nb7u8qQaE8Ket
 kdaOOeo7OwsiIPNTutaI4g1y1BsWTfwRGDQwvZ/atT8nzKw+Ni7bzj+mUbQXkjxB+Rv+aSLe
 BVYrdGOME66Ru5owTNOpB3elfqX5QfBkcU6uTO5syxYyC1JffwSY82Ac3rLKW3qE/xu3uSam
 4i1lxWDnoOlyf4jgjC3XfUS+OiV2CbAWZ42Q/EZ+ilTu6arOSfSv5yQ1cgnX/CZ2A+Uaujjp
 oD/8w520lEjmVqx0FkPL9xH+uuY6aFzavmcqG6X23ooblnwYaa1lJND/5vnJ0dqnhOMl2JeK
 gnFgJEchkbts4CMFwDlwh06svU1tdCxqtftOPi5iR8KQAAUi7a+yYIeHq1l4vZhaEQARAQAB
 wsFlBBgBAgAPBQJWjWWJAhsMBQkJZgGAAAoJEN7/muRPME1ToGMQAN5eR7zVdNCRfNsY8bcw
 xqwTgBu5sugTBghHPRLfQGZOBBg/49iu/6qDu6Q/IBIXc1963GOtd0eOD1fjdtgNzP6WTvZY
 6zzkNvcwZQpWBTlXJa2KqKzdqGyTPZSj0YlY23L461PelTuxdIxNv45pOk32yg83NTqhxBZu
 mlAuPCfFpyH4IEEEB0j+9WEZnzl9cBLzw3rVv9bEIixe5ykSmG8UHJ6FJ6cI2myru6uwzbOu
 n8DkNLspmZppoTpwzPCY/6iljBLUBzDDRD8rzEavva2IhzINkrAvNSW6VpBMSpUBgsEIKxrp
 AFS1ax5uXmwYGyFzOWy034Zz5fWi260qiFplzKCij8t7sCgzOXwEbIt76L1basrRMY7urJm8
 4VM6MeG2mfa92FfrMeL0pnD5ONg1FIuleGlvvKdQdFnE4AlwGcKid5GUD+vNNj/pbZyUpe4r
 zBFsc21/8jXSlR6zJS4mgkNDIIBGiPny3tvKINMZ8VK00mR6INpd+NErd2LxwZ/DQ5ejVyVL
 080CbiD55mxxhqkbd5fHSfdhvvXIIYN+nM/RFLwaQGW9g62iFWlqeNRXezkERDV5ahFqZMP4
 YDdodn0nRVZYu2kaXfOclKPcH58HlrRb8pKTE3t/TNKGY3SmKoznH0QtM27TWeZ9R9RgTYiV
 zSNqP+QUNp6BotWI
Message-ID: <f1281c9e-7efd-cf87-c093-b86a9014aa24@amd.com>
Date: Tue, 5 Jun 2018 08:23:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601145921.9500-1-konrad.wilk@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN1PR12CA0107.namprd12.prod.outlook.com
 (2603:10b6:802:21::42) To DM2PR12MB0170.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0170;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0170;3:/4CBB7QRQaCb/H6xB7qmeKLtPuw8SjsgdHGdAzBFmsUbVA4pGeMCGHLCOdlEZZj/jEX6DfH666J3U5Vu44Q6SuivJMKyo1qFXF3ZfEJmVKCN70KEarXY1tMCSzEln996gLJLWepnohkmCuhSeltCpMvDzIQcNgF8asKPEMPNNpRF5kTvuUJItmZre+4BqFy3nk7DC9st0y63E2ptgFFJZWgCN062XBctw2nPGqczgEVZblFvIeblz48gXoI96Iph;25:IF4G9p7+JNArqpovwkt/r1dX9NM+rlhfrpJee4GvR3nJDw/G1d2rsGpgOomsUFcfzyKIS8oJA6tjwqFdivfrJqiVQGk2LDw7jD0vMUXX8YP6/vW2zrko9pJBmAh5FoiCWGyKxT5g+BZ6YgvXpwjvmLqExArYhtYh/8fA4zeMExhEz+8JDJjsWJvskEwAPim169nge1Y4kmcht0IHnd2+Vb7EkHl+E8xnRZ40w0R018KQBLsTBoyb1KKLL36ZYVSPMix+mwL0lppwPWTkWiqccS5UMCSTsbuGhtx2VTJtImDpd6NjFtF3Iy/kBuKXoK7EjsKSA++WR+efcEPyaSSmMw==;31:0a4gvxTTN7ypJPB+11bQ+wtGgABc2IaICKJvVD8sNVs4Rm8JgxRS/YKXgx33aQWcazw50IXuB11Ix35wAIoBXVhscZLl+dhyxGeEZi3Z3C8tXtZXs+jw8w5OQsMckEvgCU1ynMViFYRZr4qjd3qBd7AY7HLVOYcbpAarhcY9XU4ODchhSn4gVFYt5tAg+TuJAtpv8+jwB7YrATpGqtGoXlbB+W8UQEmf6o/zn1Hlf0k=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0170:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0170;20:mm5+3Vj2Jpf2fcg0hChA5s7hNEtBNMPOPA928pey/htbp7ohL7ERdjtrq+L0IsPOxs2y1l3WVcSkyYn2aW1mG+AJWw7ZLjFrrnQ1QOMjwJaxPfLSfMuxKivWOCu5PbfR8zbIsREQup070Zqs7FjP8mQ4sQHg6j+PLUzfLxASW1uveaTlcV6V4Ucfc/y4iUDrs+u2/z59e17NtrB4SZpwXhR0TB4t6lC+7OkblSi+yKJ28AlXQEV5wTD60vMLCiy/T+TtaatzJAYWwdSteHOLTCqs26r1rAf8LJTb+GwUt3kC/0ZufRsqoFfoJ1zO368QehR5GYfMQ+j9LO/7BCB4rhwcsSfjV4K00cJ8hxTSPRONI1uZkBwXV+VpiQThr3XsPagmqfA7o+9hLyHqlZtE5xeHP6+GuZnTDM8B1Cw7hBdza6kKsy+Z8L8x0Qm6Md4F6ryB5n9dS1sB27G/6ixeq4GxB9TT8z1RBYercBh8c4u5+ODm6o1UwIK5RGHbRTaI;4:qMja0sy2VRpPHvGz63X8rRnyys1q7+5AdF06SM8G2ulzuXfHA5qteh5wuIBxuh9vIfzLm8DBbUTyvCpgmZ66sHHspX+cvbuPwJN30sS0kkdXkzqzm/TZyNr6EudTTbBD4ZksilPkUK4DVQivGXz4Fe/tSJSipIqoKivgc6OyZBb61XTr3FEk8TR+MTXwPfQVx65qY8IAHw7yRNPxwyz5O3Vsbd5ONvQUY3r82HUA/q0bmwMqfw8wvkZHm1zudddFt5a89OuamC+lWhzqzagKqyoVuQ0mpjT3/F66t+1xV0jhXWXmRl1WVb0X+6IFPRFv
X-Microsoft-Antispam-PRVS: <DM2PR12MB017061FBBB37216558C8E643EC660@DM2PR12MB0170.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0170;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0170;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(199004)(189003)(65956001)(2906002)(476003)(81156014)(16576012)(8676002)(81166006)(76176011)(6486002)(31686004)(53546011)(23676004)(2486003)(7736002)(52146003)(31696002)(386003)(52116002)(486006)(58126008)(47776003)(305945005)(97736004)(86362001)(106356001)(316002)(229853002)(59450400001)(8936002)(575784001)(66066001)(65806001)(956004)(966005)(65826007)(8666007)(6666003)(5660300001)(68736007)(3846002)(64126003)(6116002)(6246003)(230700001)(6306002)(186003)(2616005)(72206003)(446003)(16526019)(11346002)(26005)(36756003)(77096007)(105586002)(53936002)(3260700006)(478600001)(25786009)(50466002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0170;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTcwOzIzOndvTm1ZSDVRb3JlQUtyKzZYb2pNVEtWMlN3?=
 =?utf-8?B?b1BsWmZ0M3ZmY05GMWFGQlhjYm5XY0lVdzFuanZnYk50M0xhWGJ4c1NXOG40?=
 =?utf-8?B?Zms1YVVZSzVEcTdiVmJFbFVLTGpMdGMwSjVLY3JYNUlOejRzbFRQY1BycGpp?=
 =?utf-8?B?cFpSbjVBYnIxdDlNdFVZYmVDbjJwTFlWYi80UTZySm4xTGJuVUxnWEc2alVS?=
 =?utf-8?B?Z2tEc0dtbWNwdjhqemRmclFaMzFza3NrZ3ZKWGhaMC9COTNlWXEzUldxM1hl?=
 =?utf-8?B?T3RXQXZmOVdlU2R4bzJpNmM3aUdZT3RJMlZGbkhTL0ZYNTNJWjRsWEl6NG1v?=
 =?utf-8?B?d01KYTlKb0c5WG1zOGVrSFFqVDNsT3JtZ01obVlWRTVnekIyZGlBeXVYZjdZ?=
 =?utf-8?B?VXBqTHpYbVhwdmNWV1lOeEhmclBILzZlYzdKYXBYU3d3aXF5ZU8yY0VyK3c0?=
 =?utf-8?B?cWFsZkM2Z3ZmUDN2SFFnYXI5aHYzQzdVemFwNGxpK21CN1EwYXFneHduVy9E?=
 =?utf-8?B?RXcwK2xuUTJuOWdnTjVQWEhONWU1RjdSbzdlYllJL0p2TitGWHl1ejJkQVFR?=
 =?utf-8?B?WTRnMmFwSG5oeXliNlpmRWhGQjd2UTlvM3QyTFZDNXZYeGdoV1hIQnA5YzB6?=
 =?utf-8?B?clVYZC9uV2x4eXZTd3RyQncrT1NnRXdmUXNSWlV5T1Z1UXNQc2JTZ0FGbHFp?=
 =?utf-8?B?WGVnWDBNNlp6Zk5uL2drenhiTnBpb3JaRllMcmpvY05TL2NvSzVOQUltMzYz?=
 =?utf-8?B?Y3ZzUkpUekVlMW1IT2ZFT0FzZkdQWFg3L1BEYmNYcmdPMlFPZ1dZcEVxeUcw?=
 =?utf-8?B?eVliTUpqYXEzbTBrbm5zVHpDWFlHSnF3V0kzM2RtK2o1Z0liWUtOQ1pnU21s?=
 =?utf-8?B?VVhLSkRrUm40NC9PQTM2dWRTS0RZRUV1WWMrOTllQjhYZVllSTdmR3d6N0Q1?=
 =?utf-8?B?dllDdm04VkhaNGxqMUEydDRNUkNSKzUzSDJkS0FickszSDc2d0RTL3ZYcm13?=
 =?utf-8?B?cFp6YmdKVDZBZmNOYmwvMXBGb3VOaXFLaUdlSEdqc1d2bUl5aW9NNmszVm9j?=
 =?utf-8?B?NDFqWXhUcE9yMDhlUEY0b2M0U0lIZ0hHcmU1UzNvanBhWUtlWVludnlsT3A5?=
 =?utf-8?B?cFBxQTFpRVBtNURFd1dnU1ptQUlFbHhqMGE5NVBWeW16RDRPbU9aazJOeEFa?=
 =?utf-8?B?QnJXbi9oaGRUWnB4amJvdGtCamdhMzZxYk9ZSlpUUmxHSlBFZlBrd2ZEUnBv?=
 =?utf-8?B?YkFMQlpHUG9VSURaNTdzanhBOEJCTGtza2JvVnFadzFOMlM2MzY3ZDRpem9u?=
 =?utf-8?B?WXJOYWsxME92OFhqNjNNcVFBWU1yS2UwK2Y4Z0xaUnhCKzJCMDd1azF6L1R6?=
 =?utf-8?B?VkpoVkpuanZiQnVaT1dEeG5RaWpPT3pOQk5pbVpVbGVhY0IveitOelFOK0tv?=
 =?utf-8?B?ZHcrcEZOZnpLeFNpVEt5RmhGSnQ2ekhKVVMvQnVxaWRNY0FjOC81NDV5Z2c0?=
 =?utf-8?B?OWF6Nit4bXhTUzRHV254Z0RpdkVJL0ozYWh0RmtYZEp1ZmR3Tkd4WDFLTVNJ?=
 =?utf-8?B?V3M1OWNSd2p4T0FuYU9yME1yTWpyR0FqcEFCZlNXeEltbFk4enkrQ0piK0lN?=
 =?utf-8?B?TldoU0IyUWE0dmpzVEVrV2FuY3BpaU5GVUlNeENzNGZBalBTbFFmSUw0eFlp?=
 =?utf-8?B?aExucit3NFQzV29sWmIxb0lnaEhqdndGNHRUL1R5L21vMlo1VHBxVHdQbFVs?=
 =?utf-8?B?cjdLS3VMMllwSlZuWHNQa0FVU2JCZ2N3MkdVbXlBUU9vSktTRUdZWmc5MTF0?=
 =?utf-8?B?VU82WjJLakwwSzZQYndFSzluR0dsMVEyZWZseEhBYXIxZmRBUmFtY2o2Kzg2?=
 =?utf-8?B?UlRQa3NxM2tHcnJqNTV2THVoZUdHWldhWU5FVXdrSUZIZzJ5c2hDVGs0ei9z?=
 =?utf-8?B?TzMwbmtIejBJNmdJZFBiaGVTaDE2bEdSeG80M1F5ZEJXelJWS3FHK1lTYWJ3?=
 =?utf-8?B?Z0YvVDc2cTNLYURUZHlPcjBtZEV3cnhtL3liR0VGN1JVOXJaLzhJMVVoZ1c1?=
 =?utf-8?B?eVZ1UGUzNjgvR3V0TFIzNzVieUt4K0syTk40SDdJUHpJS3JrODBMbmZjcUVU?=
 =?utf-8?B?V2c9PQ==?=
X-Microsoft-Antispam-Message-Info: L5d2YoaFbT+0F7uixq/sVTrZSbXskoUGrRV/1CZXZfDbPCYjpOOzRwuLpYBHKd+/Ao2RLTESKS7VdbNLge5uElyYk1yVuXhy97tMhXo7M2qLDoDTbMDakWq1/4DVlF1msvTH7kffuVLNn59u4JfrcUW2TGvzmU9yIW51UecBlkIIWgv6dkLaUtiySUyjzeF9
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0170;6:Pp58evQjrDkTwaNRbaSaki03iG4wTHO12f8RcLWI0k9q5WDtZIoJKHhQg8137oO0Xv1t6fWFsb5/8ZkzSD/rLdG3P7M2+8Bm8WHa80SOcMJm0FVMqICMu43g9fhYXNQrRim9QMNvUlBPNRM4Ydhgbpvv96H8/WN+O2zOqP7zdM93kQloOl8k9Q6s5lnM2BCY3zXxNuTVpKYogPuo4hhwTvubzwr+t0ozSwzLr8x4tZZ0zz1so9KB2ptxb7LZq50ozmTlwVwEPXCLLph7bS/EVgumeqGN0s5kEN2RxOsn521kMJUZ4oQNL5/K8ADIWE7+Yz/TetR8mfmDgW1LUlO9UsHDW9lgAvCDW+jTaf5LKYMx7H4J/HkFlOMvzbLuAfyQxla4BYQuXrnei/CBismEqqGe/uzgLDctb33LFcVOLtVmMbdf00V2HzfOAbDLQGO8a9kUIvvxk8dC0TCfUqghbQ==;5:SGIDLRAirUDIxL0Pawx0ng6sovwW18cCRJXVv5KBAyJLkXzvRRSxYu6ndPr7DpC0MsPcJ1ptDCZt2VRA+QPqlSPTRyA30bd4zsGPOAk38b6lHbOY++yRXKdzjrAT97Gt0CclsTx8hYjTMnULLroxevowfqxgf4+mgMgwO4QR0VM=;24:ZmeRGfbfGMZExCTe214USZKZfnYa0oP+WvgB8X4hBMRWHH478jUDISR88JYs4hExKirfnKPHK7o+7U1bZsK4+0Se+yjKJvT+oxHpnV8qyWs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0170;7:f/6RLUUIwN05YtcGzuw1GWTgp5mcDLdpJ0YBYamEHglEF49mJw+drVAKuOs8mDsfzIV8J8qmpYN58oEfNjOxKBl/cVVQZlGwp3809fy+dp+rCbTPVFW8q2df75ikr69jYRePbZW13eBBrIE4Sp0XKVLDltBrkd6kZbrfzgdQWd45RMJvcWnU149X37FNzmqKIrGYOvR4euKudUlK+3I++U77vjpG2LqPC4qNChk5eeL4zriUzyNk6EoA8C514UUq;20:LhHALzBNAxvc2xN6kloXxL6GBfqqvCXveE36tRmyeNXQ9ye4tkm4kyVagPsDnHSF1C9G6OyMEwLkDpBHgNAbbN1jjDFKFSziFb+PXkF2O1ERxLSWom075JeFUn5Mw6cFxLwonMoGsdOUwiMyZ+QodWhD4ozr4f7z6akL95uEqRUpqqmQDCCr1dmQXoSFHgcZgEvNiiJtup1ZFE0FrNeqauXOgE9wous3L/Esyzj5C8wE6aFcrxgVYdInttNvnjgZ
X-MS-Office365-Filtering-Correlation-Id: 71dc965a-862b-456f-9f88-08d5cae77f9f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 13:23:16.6466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dc965a-862b-456f-9f88-08d5cae77f9f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0170
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/2018 9:59 AM, Konrad Rzeszutek Wilk wrote:
> Hi,
> 
> I was reading the AMD whitepaper on SSBD and noticed that they have added
> two new bits in the 8000_0008 CPUID. EBX:
>  1) Bit[26] - similar to Intel's SSB_NO not needed anymore.
>  2) Bit[24] - use SPEC_CTRL MSR (0x48) instead of VIRT SPEC_CTRL MSR
>     (0xC001_011f).
> 
> See 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> (A copy of this document is available at
>     https://bugzilla.kernel.org/show_bug.cgi?id=199889)
> 
> Being that I don't have the hardware (not even sure if AMD has developed it yet)
> I ended up cobbling up a DEBUG patch, the last one - which is well, debug
> (see below).

So I'm not sure what is debug and what isn't, so I'm just commenting as if
they weren't debug.  If this patch is just for debug, then you can
probably ignore.

> 
> QEMU patches will be sent in another patchset.
> 
>  arch/x86/include/asm/cpufeatures.h |  2 ++
>  arch/x86/kernel/cpu/bugs.c         | 13 +++++--------
>  arch/x86/kernel/cpu/common.c       |  9 ++++++++-
>  arch/x86/kvm/cpuid.c               | 10 ++++++++--
>  arch/x86/kvm/svm.c                 |  8 +++++---
>  5 files changed, 28 insertions(+), 14 deletions(-)
> Konrad Rzeszutek Wilk (3):
>       x86/bugs: Add AMD's variant of SSB_NO.
>       x86/bugs: Add AMD's SPEC_CTRL MSR usage
>       x86/bugs: Switch the selection of mitigation from CPU vendor to CPU features
> 
> 
> From 3d120f90731dae7e9a6f0c941c8bc228ed346baa Mon Sep 17 00:00:00 2001
> From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Date: Thu, 31 May 2018 20:56:08 -0400
> Subject: [PATCH] DEBUG HACK DEBUG
> 
> Expose the two various Bits to the guest depending on the module
> parameters.
> 
> Also show the various hidden flags in the /proc/cpuinfo.
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 14 +++++++-------
>  arch/x86/kvm/cpuid.c               | 12 ++++++++++++
>  arch/x86/kvm/svm.c                 | 13 -------------
>  3 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 5701f5cecd31..05b74564089a 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -206,15 +206,15 @@
>  #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
>  #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
>  #define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
> -#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
> +#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /*  MSR SPEC_CTRL is implemented */
>  #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
>  #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
>  #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
>  #define X86_FEATURE_SEV			( 7*32+20) /* AMD Secure Encrypted Virtualization */
>  #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
>  #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
> -#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
> -#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* "" AMD SSBD implementation via LS_CFG MSR */
> +#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /*  Disable Speculative Store Bypass. */
> +#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /*  AMD SSBD implementation via LS_CFG MSR */
>  #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
>  #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
>  #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
> @@ -279,12 +279,12 @@
>  #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
>  #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
>  #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
> -#define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
> +#define X86_FEATURE_AMD_IBPB		(13*32+12) /*  Indirect Branch Prediction Barrier */

Do you really want to remove the double quotes?  This will cause lscpu /
cpuinfo to display ibpb and amd_ibpb in the flags.  I think just having
the ibpb flag is what was intended.  Ditto below on stibp and ssbd, too.

>  #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
> -#define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
> -#define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
> +#define X86_FEATURE_AMD_STIBP		(13*32+15) /*  Single Thread Indirect Branch Predictors */
> +#define X86_FEATURE_AMD_SSBD		(13*32+24) /*  Speculative Store Bypass Disable */
>  #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
> -#define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
> +#define X86_FEATURE_AMD_SSB_NO		(13*32+26) /*  Speculative Store Bypass is fixed in hardware. */
>  
>  /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
>  #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index f4f30d0c25c4..67c5d4eb32ac 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -27,6 +27,12 @@
>  #include "trace.h"
>  #include "pmu.h"
>  
> +static bool __read_mostly expose_amd_ssb_no = 0;
> +module_param(expose_amd_ssb_no, bool, S_IRUGO | S_IWUSR);
> +
> +static bool __read_mostly expose_amd_spec_ctrl = 0;
> +module_param(expose_amd_spec_ctrl, bool, S_IRUGO | S_IWUSR);
> +
>  static u32 xstate_required_size(u64 xstate_bv, bool compacted)
>  {
>  	int feature_bit = 0;
> @@ -672,6 +678,12 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
>  		    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  			entry->ebx |= F(VIRT_SSBD);
> +
> +		if (expose_amd_spec_ctrl && !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +			entry->ebx |= F(AMD_SSBD);
> +
> +		if (expose_amd_ssb_no && !boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +			entry->ebx |= F(AMD_SSB_NO);

I'm not sure about the purpose of the module parameters.  Shouldn't you
add F(AMD_SSBD) and F(AMD_SSB_NO) to kvm_cpuid_8000_0008_ebx_x86_features
and allow cpuid_mask() to keep or clear them?

>  		break;
>  	}
>  	case 0x80000019:
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 950ec50f77c3..a4c71b37df74 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -288,7 +288,6 @@ static const struct svm_direct_access_msrs {
>  	{ .index = MSR_CSTAR,				.always = true  },
>  	{ .index = MSR_SYSCALL_MASK,			.always = true  },
>  #endif
> -	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },
>  	{ .index = MSR_IA32_PRED_CMD,			.always = false },
>  	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
>  	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
> @@ -4231,18 +4230,6 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		if (!data)
>  			break;
>  
> -		/*
> -		 * For non-nested:
> -		 * When it's written (to non-zero) for the first time, pass
> -		 * it through.
> -		 *
> -		 * For nested:
> -		 * The handling of the MSR bitmap for L2 guests is done in
> -		 * nested_svm_vmrun_msrpm.
> -		 * We update the L1 MSR bit as well since it will end up
> -		 * touching the MSR anyway now.
> -		 */
> -		set_msr_interception(svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);

Removing this will cause the MSR to always be intercepted, when, in fact,
we don't want it to be intercepted after the first time it is written as
non-zero.

Thanks,
Tom

>  		break;
>  	case MSR_IA32_PRED_CMD:
>  		if (!msr->host_initiated &&
> 
