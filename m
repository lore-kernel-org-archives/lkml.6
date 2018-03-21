Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeCUTpt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 15:45:49 -0400
Received: from mx61.netapp.com ([216.240.31.181]:17146 "EHLO mx61.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752833AbeCUTpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 15:45:47 -0400
X-IronPort-AV: E=Sophos;i="5.48,341,1517904000";
   d="scan'208";a="14847011"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com;
Subject: Re: linux-next: please clean up the nfs-anna tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180321111140.618e1e6c@canb.auug.org.au>
From: Anna Schumaker <Anna.Schumaker@Netapp.com>
Message-ID: <df592a0d-8318-7a7c-386c-07838351524a@Netapp.com>
Date: Wed, 21 Mar 2018 15:36:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321111140.618e1e6c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [68.40.188.1]
X-ClientProxiedBy: DM5PR1601CA0032.namprd16.prod.outlook.com
 (2603:10b6:4:5e::45) To DM5PR06MB3162.namprd06.prod.outlook.com
 (2603:10b6:4:41::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac2e444-ff37-4089-4677-08d58f62fe30
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR06MB3162;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3162;3:7WLvMlAB4X33oEIxFFYo7BngdWazrblhtXclPuivpU0ue0vJ+T5pOIf5eWg99zdqaogbeyboz1Q+hFESBBmKxfmCKKS+UxlIY84dk1sTN5rzO7SX6ZEhMODbf4pFXw8l9mkwWHajIWWqOckbXMix5pXkmj1/Hi6hvUjPCWN9m84KqN7e6UKNDNmg7ZfSwlKc3g25SWo2vQuf0ef+mqGwpX/KR0HTlgx5pMe5KZmIW/wgbnQ4y2/UBNt2eX6cK8v6;25:gxmgGUleLQMGwAVSjmvLbb564xOB5srLuqpWKBm6uFtxA2UBvm6AB7LoGtaFwcEk9+LgwsPVPQqDQQPSqPxPd6q+Zz7cgVQ6k6ELXd2cgRDrXydG0QR2xgyQ47hImXPZ5sDB8aJXKVIT74obpeLMeqGKZIyyCyLZQzCm875kbFpDNxoekOdY5jEC2gp3hbL1fNNjA+IZSmE8wZmBYol8t5n3Pxh7FtNSM8WrF5Igua5C2moLe8BM9jMRbLL19sg5wsx2JutA7+oeKGrZ8Cy09Zt9YWhSe9u7CpuM7ZJlmqmNSG5OTSHWtcVAzgJ8l0gXPFnVPAgaYqSRLWoz9uYOLQ==;31:BSmuSiYUwxF7s4g+h4vL2VWXmWgIUfCCDquVtvZKIHylo9p514jYAtz2PDAla9LUA3Yiv/O48hFOjvFI0okJMGU3YA9Cq1sVEhdbF73F1ZR0yLxFDJrIcDm+GlGxPML2P0jYW5a03vg+2NGFIGG8hUKAenOLH8RwN9+sOoEME4ytMhpuZV7W4EgJUmLZVCLCq5ujh0NX7LL/7TLG7i2/XqdNxXE7xO08G9hRG3JnMJw=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3162:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3162;20:poEf1v6FXYzztktD/O9tpMMIMti8127fD1ZxhQJQIKmc6OaeccM2Ye9zTzmWFZbo0Zf8qt5iyz6TYGguL3cLVFebqtcmu1dN6mSCxJG+hBBAjZLiKGoesdg9pXLBuE9lRxQAsfea2pnmiiu8Ttp7sznyag+jhT5XLutmJ2+vuRKxCpPWeat+4xSfSY6DAyrOeZ6pQdMOxzXi2OqzjNW2OY1hejlqJguBLoD2BQi+Yw3mqX/wTVdV51i/ELr8yUBNcqM9nu3NI3nNrF1tWej0fi6dMhnbll3uR3Jeu2jnUiyZqD421SzSSu5pgyU1mT5mkBpiq25NGCNvhLCB+pQhD2KfD9IIp+yoWtG/SvsxOQ2yhOHGWDizujJIgxIBTiaM5bhnMsu8XivWDxkR+XtBRZHIPc1VGUgenhJyOvqGn9iDpT4P5OfpH1kE8g7lEb3ELSUkWwQUyJz/Kg2TNNwlXTO2Cn67gdI/elO2SkXCZCeqDoOzQJAs8qgWuQnKQmDC;4:UzQ2KzNqfsODg0aeu4X7Kb+4+rROolcEi20urjWUMJjJh24dAZ+Fw3/aULJaLs39B0Q5LV1B7to2mah6SdNrXAT8oRCC2L27IZRoN2gUlqeOJxeazW3OZfPCqobGwX1d8jou4N3uQC8P/M/A9rlOT10mW6ZIuqCTBUV6raeq44tpR7KKJJdrz/X5H1tIYyh9bfx0+LhiRGBnU3Dr+YUeMugtN1UPaOqaExez+M9H4BZzygTlXP9ahMtA+5l6/g0/ossDoBnJi2ua0v17sFJGtg==
X-Microsoft-Antispam-PRVS: <DM5PR06MB316241B9CAF335A83E778851F8AA0@DM5PR06MB3162.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501326)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR06MB3162;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3162;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(53754006)(106356001)(3846002)(6666003)(2950100002)(229853002)(8676002)(53936002)(64126003)(50466002)(86362001)(6486002)(105586002)(6246003)(26005)(76176011)(65826007)(52116002)(31696002)(230700001)(4326008)(25786009)(6512007)(6116002)(81166006)(81156014)(97736004)(65806001)(316002)(36756003)(58126008)(5660300001)(2906002)(186003)(8936002)(110136005)(69596002)(16526019)(305945005)(66066001)(7736002)(54906003)(65956001)(47776003)(23746002)(72206003)(386003)(478600001)(6506007)(53416004)(68736007)(53546011)(31686004)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3162;H:gouda.nowheycreamery.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM5PR06MB3162;23:GcW7pA0gXT2MFalJrZQFEAU+gLdeWXBLYTLPv?=
 =?Windows-1252?Q?d3UWNscan3b7qQKoClRuqmjmZQPD+xbhUGZkbSZ5Ua2Dllm4v7ttUBsy?=
 =?Windows-1252?Q?8MRkxnYXki2d85l28nY9CmQsSKO3YwWnuFFkWd0x/OvPsq/3bn00f0EY?=
 =?Windows-1252?Q?pW8Qa4nvnKw9AszeBQ1iWPwJp28Pd0B5IT/ggTTV2JnNbSsm+ZqAF+Uy?=
 =?Windows-1252?Q?yenP+RBDqBYOnRTBn5L1D8nYTBBCtPiVOwSDS0VG8uigsJA/0L6CebDM?=
 =?Windows-1252?Q?RKiCnwTke4/zOyVG21AI5xKhYtn5UZ8Lc4/YvV8hRTkEDu/6R6jSHVpi?=
 =?Windows-1252?Q?sMvm3ysPZ3eid8DZIw8pOeJbCunaFUxAydm4GiqhGdql4TVgd7+Tskjt?=
 =?Windows-1252?Q?iCpThvWCcMr970d0uK5CGEQqTj5fUeCNWrck88lUzOFm2CHSSdxmw7eR?=
 =?Windows-1252?Q?1ZBcH0CPY8a7ERABSIACtWh+TR4uIsE/anDaoPbepUGsJyx22MxGaL+6?=
 =?Windows-1252?Q?+q/a2VhmZIS1Q7CvcbSDBeBiUNYKwi88oExlpFzMIKsttaF72fT8HC2p?=
 =?Windows-1252?Q?CnRDV9GhiTBepbIW+yZAm0OU+nReRpfgBOe5Oqrvc57WZQIxz89wO4cV?=
 =?Windows-1252?Q?Ya7A+4D2vjTYG1Q9EHpUjJmv9JEhJqgI9K4LEAKEUZ81h2ZvL369fpDK?=
 =?Windows-1252?Q?AJyL5i5bi0aR98Tkm/OzQ+jJ/Hv+kZp21O5PGby0dIhdXI38LJyM2xwx?=
 =?Windows-1252?Q?q5Ig1EcE6owQJwd+e/vzWnyru9WhbzV3cToVoHob/T5IAsBqzsvnb6iA?=
 =?Windows-1252?Q?ItfyxB8ru/XULheeRXqyjQvJ5eyxfJ+esdj13orvejae7Xk2WvMJiOzz?=
 =?Windows-1252?Q?HD5SKzjIteMehNixbr7BXkv/gc9wfXm2sERJS53SaVS/733RtREGGM+O?=
 =?Windows-1252?Q?WefghsRJ/HMW4H++1THXYIv9/k37JZs/kijFHrAfFJkfuA303lpYKGWC?=
 =?Windows-1252?Q?wIefIMhXZ6sbj/idwQOz3dgG0xvlVsTCrfqHyBHNFGp3hsLx4WVDQ1tA?=
 =?Windows-1252?Q?FTymIs+c7bOjFXEgENmrFABdj8bmhObcuKlKZLe5+iYFTYeozhSzggd1?=
 =?Windows-1252?Q?t5VTUgyysxTyV5vEaQRtcwN70LNBJV5MUEDmTq+3RxUwK315Y59sGaQ+?=
 =?Windows-1252?Q?BlUOypqUi1UW0wlRGbEXRduCDb4x3mFbLlmCjWIxYgGSgotg/iJdwsrC?=
 =?Windows-1252?Q?++aZ94Ss7KEq8MhQfB3IiC/K9+5MhauHCDLc92NR14tYeObKQJQoaTBE?=
 =?Windows-1252?Q?4Qbxjjld+QkCSQCWRITS/qz1PMXozZQVi/BmgKqCgOwgmZ41rt/fJQEF?=
 =?Windows-1252?Q?afk7maqqTG/D7uwDgSPbbDKj0sg9NnpgqL/RVLiNM+zJXRx+zFZIowAl?=
 =?Windows-1252?Q?wFczYtmhNdByQlcwloKmW4OElnggaIJAkoEHlwKXMoaQQs/6hCh2ysTK?=
 =?Windows-1252?Q?RAwKe3P0hEGQUQ6vVyh5LRjRja/?=
X-Microsoft-Antispam-Message-Info: Yg6GYAsP3G1JRU82lWD83Pc55CFOkpwddGskdZauR8ZriEiLynUWyb75Aw8cRBtPKNals8Hg6WrnPQBEhk9E7cmiGOjBnXPCOX4iOkBd78ihimAs6jtJkhTmIw8BMy8RgRr71qkYgePF23ErvXHte+LCcwmRv8zNzWn6fPpVApXyuZ685aU6/5xAr2tWTsUV
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3162;6:9gx1NlDf0IPWj2Z1LxarOZbjaj9AqQJkacemu5xE4GCkRmxHxWRiOptz1DVwlAz98h8Fa3LMRorWBus708igGWZrfHxzeLql7gj1Ny44DtIKCB4Kyipy0zL9HQCQU4b/O4U6spYlM/KKG1grm12Zr30KzqY1m8b/AeC4Dwqe497GXTsDrDygQKYX/7ZM2SzywWmkZ17TPRmAn/ZyAbFwvfLa7c+irKWjlh6Bxsx8epI628iEDd2RkGqCQrXw7Ud0umv91UmP0PxJ3MbSg/HWVfO3Nw3GPyf6LnHiEXgNgKjE5Pc9cZsvJs2ZH3icJQDG/sEx9UpkyD/yLAsmKjAGJnsutHJCq0RH/Ws3XKmdWQE=;5:DSW0TYK07UE+jLyY3eiVXCCm8PMX8nWQiTYMatNh1dicxaH15+or3lFpAyQnpWQL28y2N/cr1dBBVErNSyDkqhjn3kVM6HwO6KANjKhHeZHHl6sFGYiKNT1NoL2f3YZOfmWToFHZcFiKY/J2y1AL4rJ8j48nny8uErPbryyU4rw=;24:MBqoEi+w9AeFtOlLPY25J2U/Wakke3x0U4Picf7K33T6NnEngcI62ga5c6DAObiwTH8Kg33RJiVVTog0WSAIJrJxOZfMtp35T2Fe+CWkDPU=;7:rFzdvMgQl4tOqJp8CP0IL8FhuCYNVzNlNxr/ZJk26SkoXPqdl4OJynkC/3KvoUQQvMdXaG4VPLcLT+KN6OfbNouZcrcQvEvh5kdpRUTSfd+eDOKIodPJWP8/hsDF/jb+bwNe22OqXiFi6TWaA7DBtObUcC+D2nxumcL0yJhcQnk1q5YV4UL2CPOIZIYXbBZYkB3z6HxQz/N4HW4CkCsCa+o5qs4PpaXS93rnZXGcc1eS3FQyBtNAbM1W3KkTZJ43
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 19:36:07.0686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac2e444-ff37-4089-4677-08d58f62fe30
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3162
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/20/2018 08:11 PM, Stephen Rothwell wrote:
> Hi all,
> 
> It only seems to contain commits that have been upsreamed as different
> commits and is causing conflicts:
> 
> CONFLICT (content): Merge conflict in net/sunrpc/xprtrdma/transport.c
> CONFLICT (content): Merge conflict in net/sunrpc/xprt.c

Sorry about that!  I've updated the tree, and added in patches for 4.17 while I was at it

Anna
> 
