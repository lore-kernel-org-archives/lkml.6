Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEPRts (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:49:48 -0400
Received: from mail-he1eur01on0080.outbound.protection.outlook.com ([104.47.0.80]:51418
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751096AbeEPRtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:49:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Date: Wed, 16 May 2018 11:49:33 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180516174933.GN25675@mellanox.com>
References: <20180406160541.GA28094@ziepe.ca>
 <20180516173908.GA21169@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516173908.GA21169@asgard.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::23) To VI1PR05MB4462.eurprd05.prod.outlook.com
 (2603:10a6:803:43::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;3:nGnyrXptbDKUXsJVv7YKb/sBkcbA/TPTCyBr9nJOaUXrRvWdttuqOnGVNVSxZtqTvjJJRnS0cPGZ/5hC9drNiyuUVPXKxKXzDqFayZhGorFoRVHxM1Z1ffAqSCESTlj6flrikJ4iK2KiOgKyZ/NsspNOP4aIusPGn29MjQvkdDtX9SYCqFzI1PdBEQLvQgi/lwlc7nZtjkzAoM7kYuHrhu/J9kK9MI4dMHV7yuWj59z9XtNxNWuTL8WC7yjh7EqK;25:YPIos5LL69GafeELxwsDLoS2p064CEJDkqoeKDP4Rh1h0FC3BVS5FBJMGr8P/V/hcuNurFpX00ay7Lf8AA1R3hZRFJhxi130vsbCDqx9MymDYXvwyQ+f2BDMl1v14CjrXsojTy9EjRtf1iLv1g5ZIBYc4PVp6LsGfy7zGg9PPC1A1g2AzyaYLPFvV2/2NslmiYIyq41yxqBw7V97hJyPID+mrqj5CH0PD14Mnraw5a6sB0Kj98N+7pdJDx+A9ZfDUhbpiTCBqQDREGSzNR4EQo1+2zuXY4+dLDVxVW8j0ppRkidDQurUaRiz5NfU0ttVDcniPCadhp3eQ+bGRRaN6w==;31:M3cIdO8uNsfq0tRMdPpFL5+89If8xInViU5uz1uf+HodRCpv52Aywpyfn7EmvU3+Nu7xcKw+5dXymyqFVHi3h/dCbKUB8M+xO/AAfecF1MpMQpbwK6fFRaGiVkl9eRFmRT0qKB1KQrs54WlUZu3fPoQqt043XyEgMl/Pqx9Zm4wmEOEmfsdHwlwUyPbuNMcNGk8M2HdNqhV4VzaXIwjK+VEM0hhr+lK5nJbwqm2108o=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4462:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;20:XVIPQK1K6aHHKpG5LS43FUA4nBIilIyoQZmRVNsjYQ4CYb1iMPrNIsKeQJu7q9gSE9pzq+282YfNc/vvz3p/rFpk+AsZ06q8GiH0JZDAEGtKjX/aQIOJd3P1KaHFnmTYiEbYHfCdZDhYK6VrpK5CFmiaQBncMsjd1N4xEuef/vwco9J2TIpXwIOGo2i4WXGLk7PP9F+4wNQ36G6Gb4yXJMhp0ivbLDLBeogzxCzcBgUmH4tjbhXEkxFe9A0iHgy9gSgt6pd6ZEx3kZouAd9MEDaxDLVAwPM4prrFxo1AOfiXSyqwyWxmhfMq2EsB5XneJtF1gLtwyrum0W39ZypfHDzAowDzjnpnnbavDScB050Isql4v4OFGHAwO7YqHKpkqonjMK+qZ2oFdFExn3lUNaqTnbZklcWob4LgeLm4i5c9ZLgGQSf5cZe78oKkcGLNNIlMKqxstmLZZkpyt720/fhnVZBS0ONZw22Q3UpJ3DDrSJkE/idMWGwQGhZthtbd;4:NKUY+1E4d8pmqEdpqaLTwBbvrhSnxj9YrDr3De0Ku1AjXwrqxQxokkhg7hr6qqtimvwS5KOVm7ZMZ3jm8wcnjANp2TPMkX/yNL9Ya/xx5b45If9as/s/E23oVxAi3YEvkXduh+b2JC75katHfedBfPkVQiv6iYWPLe5bQ9+OQIWruXJHlPjMFfppsGvMD52ngmhU8ZcRqlZdwcXkkrdgKkssiN3LbTNNkxO477336CAEH+TY5j2uETtpo9mRGYlIJlGU+6YLm01mmdA+JCKVbA==
X-Microsoft-Antispam-PRVS: <VI1PR05MB4462B6FE7CF45104E665FCD5CF920@VI1PR05MB4462.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR05MB4462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4462;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(39380400002)(199004)(189003)(186003)(76176011)(7736002)(305945005)(229853002)(106356001)(105586002)(3846002)(6116002)(23726003)(57986006)(83796002)(1076002)(386003)(6246003)(46656002)(58126008)(33656002)(66066001)(6306002)(8676002)(47776003)(54906003)(52116002)(69596002)(16586007)(81166006)(26005)(316002)(81156014)(53936002)(6916009)(5660300001)(8936002)(50466002)(36756003)(122856001)(9786002)(966005)(478600001)(86362001)(97736004)(9746002)(476003)(11346002)(4326008)(2906002)(446003)(68736007)(2616005)(486006)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4462;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4462;23:Ik9ao1d84teAY9WxCSIq+fH9oqW8X20Sb0QXuNGTS?=
 =?us-ascii?Q?tS+SoPzBOZ3SdG/zA/GWFz8SsTyPDvBBerf8joeWAn/BHXW0+B3WTLJFIj18?=
 =?us-ascii?Q?ZtANWKYJkrdWEEpWyEVMSdFMoTQ8JgIsuQRPMNR1u6wAwEr3eS/X2miJTdXz?=
 =?us-ascii?Q?bOpavfaH/HC5Z7sa4EYnL1bROSc34aj4p1IdhNh7I1hoWwzmoXF72ImZmChf?=
 =?us-ascii?Q?MnK0mW30+Lv3/ZcK86DD9TSUK8uJ2vC1KU3301lbX+hJj7C4UUoeabKTuVXS?=
 =?us-ascii?Q?CX58qxRhaM22Bv9ZkRXImAUHhxKLgxikAmdJfeKay6BoT23/ANLpvE5NTi0Y?=
 =?us-ascii?Q?FkS8cDRv/JX7KGmZbeBuMSqfHOPMSMrp/aFd4mWquX1y9la0TocAhfrrDrhD?=
 =?us-ascii?Q?8EpW/rW4VanZibqJr20AWGTc8cwMQozHGC3U+zOUDHw0YlqvzVVW7IHqFoZz?=
 =?us-ascii?Q?/R8vGzvPitDXkvP9AINSK3diQat//HQc29HIF0/z4Di20aQUOPP/YBrDTAhk?=
 =?us-ascii?Q?LGo4ZVPlqK1Vyn46hhX5WU1jg88kwqgdPHdm/rRuf8dUzhUUIAP36sD9YtAp?=
 =?us-ascii?Q?BAlNsBfI9nq1zhI6ucxunNYFM+OX+Eog7/yLsjdW6/W5z/pAbELPw9KdI2nv?=
 =?us-ascii?Q?TjxRL8F7eLwm/FwMTx8TsOAlTqZb/Ftyzak6OzB0YlhmShysQ7llNExMSBYJ?=
 =?us-ascii?Q?keA+L9gcSms6OvsPW9rY8Qp3jtfxjHgAg0XYPbHNa4cHtx9gRq7k9op0JEQ0?=
 =?us-ascii?Q?m3/H6KLkEdQq2R2rRgTvBCogcR9eyiTUf5MNjWBaJMyzbJUf9OEb5o0Hu9UF?=
 =?us-ascii?Q?PE2aEwi00uNLbrlXTVAtP8vaq17X66b8ghuKnZae0qiT67lDmNCBCoEW8EKt?=
 =?us-ascii?Q?mmnePqpA9XheK9j+FBUOz4UuoOSAMh8G6U1mBxTzb9PuYjXYj0Ci7jVhjWTd?=
 =?us-ascii?Q?ugkd5PKoNRkKfS4tHRkrTe6rnoEPiUhh9oQIu1iXRLEeOQgRg70ROhEwRprN?=
 =?us-ascii?Q?WikeFT6CXdloYOX9CBBvTFrbHtg7BB84pW02xSrWYoh8KpxO5iouq1fWJ6ok?=
 =?us-ascii?Q?rdBfRSDjDLnRclMWC9E0l0tVaIjFLSa33pZYK10i0r1wMkYnPzSJIaaFaT7X?=
 =?us-ascii?Q?TLTJQKOiKrQG4h1PA9GyY88N3qewpLTSBlhhCmf+nZ/VV7/xBIIBDIb5r+ga?=
 =?us-ascii?Q?piFsqHhPnSh3XStT01i9GzKvMxO46hsbLKAVTX/aomvHg6UJaj+oxQuEce1t?=
 =?us-ascii?Q?ZYzN3VUreCySRiOLdArpsu6iE/hR+3PkB+F6lsSdCJNjkhtx6zrVzrt75NQA?=
 =?us-ascii?Q?eHICL33xaz6KDcE17W1OaNXyU5RQOtkV0ktkCTiAP4znk7iYqzmYnDuI4te+?=
 =?us-ascii?Q?CSmnbGzqDMOB07Z3P/ZhN6QAfI=3D?=
X-Microsoft-Antispam-Message-Info: v/864OVGnMY/iFX21hVf465BnI2ZFP13UU0EaUrO0pxfZygw3hCkxhq+JQxircGTr77QRKcUQ9c1Uaud6xQe5utlZw68ShmwfxQnUGjKp7RUvVldX1D2l0EhquUAdtQHw9xrFnH1mYBNhayLZXOTB0S1D7ydwJXl7n8Q2B1PvhfiGc3RVRgomhMgB6M+BcRy
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;6:6cX5VtiU1BYAwgYzDgCLGmAidKVZeUWhIL6ViJs66wTPlr7/uTfzwH6/9yugAUSLWOs0DQRde7yfONZTjwhVwwOXwShd3a+u7iNM+oIl7mXwc6eBGp4aI/FUdAPNL4vWDUD8TlP56MKRzontHgEfp1mVYj/hSdP1gAb4JlZrZJwPIHWx2AXEFrxRyvq3w6U4/0ZJ/WdhwRrE3lTXdlVrmzcaWEFDTkHXoPcVkJUN69k8b4/jWS/FML/yoLf7b9a7g0fpwEw2iCKYgBTdpatEsaoU5dUP12tWpG0UdoJCP1tPNAHkSkn5gsmZmI+4DKoNxLJ2YNeTpERO2c+6JO7cLCI8HHMcjrHy8P7Pumpq4WcwLVY7HacmyFGazT5xcYOOeo0GZOmGWIJBzz4+q+36eNaEzTD4dqftP85ENjkkFHI/V+sXDgY2kAQ+RETRFrEfbw293zpjXdCJ8RZjy+fGGw==;5:T3HVazgTTVQuPnDyfN/pGKpzeSU0P2KO9iXLJt3jOfnyU+lXiz3Tl80yL1GjnnOhN01BpuAKxu9E+9liyD8kotjbCBjGZefVrAk4calg7JNYkbPLDGeNavGGUlnco9qMvd3ZBvcF+NKKilYQgxWXRlpXee2JNtUkhgtDfKA1pcQ=;24:+zYa8aPQqElghG+ejKf0W0xl2VDndL54bH3kuVreChuXogvIbhW0GpYCGmBD0glQBq+hUbjN09cUztInaEP7RuDiQlvOfIHp4Bl+uuFF1Fs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4462;7:sRKX8FarjIyUZdV51mlauZicy6jeXl0Yn7orlG2f6JvMBF44ccVrYNcN4QKPWhTHFXJmanRf93e7Vy5ugK1SpUM7M8BRnM3G0n/qTCA2EgSEL3I2Oilb3not5KyCseFha2EN0k+fqjuBxfo0axo29EdQappf2YroyCwduP+sMHdrWH8FKtxcaNALA15Ew04hkH9iL0gGrVbQiNi1IQ1qQCvlJHBUCi+lWV+znJj0GIvGWGXBb1eEMK0tEH4JHoSf
X-MS-Office365-Filtering-Correlation-Id: 154e03a8-a0b7-4d25-01b8-08d5bb5566b6
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 17:49:41.0736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154e03a8-a0b7-4d25-01b8-08d5bb5566b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4462
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 07:39:08PM +0200, Eugene Syromiatnikov wrote:
> On Fri, Apr 06, 2018 at 10:05:41AM -0600, Jason Gunthorpe wrote:
> >       RDMA: Change all uapi headers to use __aligned_u64 instead of __u64
> Looks like this change changed the size of struct hfi1_ctxt_info and the
> value of HFI1_IOCTL_CTXT_INFO ioctl number as a result.

Only on 32 bit..

HF1 does not build on 32 bit kernels, so the 32 bit version of the
ioctl is never supported.

HFI1 also does not define '.compat_ioctl' so even a 32 bit user space
on 64 bit kernel cannot call this ioctl.

So, yes it changed, but it doesn't matter.

> >       IB/uverbs: Extend uverbs_ioctl header with driver_id
> This patch changed the value of the RDMA_VERBS_IOCTL ioctl number.
> 
> (see https://lists.strace.io/pipermail/strace-devel/2018-May/008196.html
> for the reference)

Yes.

RDMA_VERBS_IOCTL has been considered experimental and was protected by
a CONFIG option.

After the above commit the experimental was dropped and the ABI was
fixed, but prior to doing so, the struct was revised based on
feedback.

There is no userspace user of the old struct, only the new struct.

Basically from strace's perspective it should use the new ioctl #'s
across all kernel revs and it will be correct as there is no user
space that will issue the old ioctls.

Jason
