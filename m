Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeC3DTx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 23:19:53 -0400
Received: from mail-bl2nam02on0079.outbound.protection.outlook.com ([104.47.38.79]:48480
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752611AbeC3DTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 23:19:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 30 Mar 2018 11:19:29 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ARM Maintainers <arm@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: update entry for entry for ARM/berlin
Message-ID: <20180330111929.7c2ea036@xhacker.debian>
In-Reply-To: <20180329130804.GB3798@lunn.ch>
References: <20180329164240.20cfddbc@xhacker.debian>
        <20180329130804.GB3798@lunn.ch>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OS2PR01CA0109.jpnprd01.prod.outlook.com (10.174.152.155) To
 BN6PR03MB2628.namprd03.prod.outlook.com (10.173.143.139)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a51d54-276d-4c1b-4699-08d595ed17d2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2628;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;3:PX9owllZ0k4Egd7RwHevY+35QIjWjr+VnHsIAyLwK9DYx6u7Y2UjPnNJf3OxJnLH6HxZN2oP/mzNVenI3LIpKRWkDmqXxLoa7wp3WEPcgn0dTaDCbRMYii4Oqb3DPGv7hV4/CggBxepB9cgY+WZrreurO2lob+wVjX3MZaFNTuG9BSY6FQ2RKCuqwP9CrhFTt9KZxwkygpL4Un7OYc4Fd5SQ51JqvuaTzxgWGvAWnG+N/dd64yJsL4SVRR3HaNph;25:lYW3xX9Wy0rqIhPYSuV+xbfTcC65jo2+g6mDHaEqGznAfowee48Ms4V0DUkLnKvSZ8Juvte+8zUe0jboZggkToeiBefITd1tQp+fgoQJSnxBngPAjszdUd2TglBDRjuZlXhvn0Ul24HdYqWJPWOuzlDQ5ZrijEal/c0MMy6CUTmy4FTvlfh5QeN+aFWynSh6dtpKMGzD9ojfJsPwQIctLVboMN0+xIirNSf1p/xji3UFX/PQ2WDngLXoQCfvVq41TlvGDWLKNpA9oWBAPe3XyHzMWn7b+UO2rHVlu/SnlZsFlS2PwtATWufWscWlBkXyB0KravglP3vAaKHQv+BZrw==;31:C2kn/xneH9qty/bZsEigN522QkGxpI1KFvMX8qbJmvvu260+6rSYEymOnucQNU0ApKyqhgo77mac3cODgw/4rvtUAJ6MupB7A5+TvBRPgr9Q8Yr4sMpVIda9gKufy+anpq4C3ccgmrqG5fvN1CE6c5C7CBNxKc20NGMuolKCNh+/UjRofHYn9z01JPHLOaRAsqpONHG4iv4ooyldQrHavQtrU0M9mnAuPQhcWtkdJh8=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2628:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;20:OLucKLyl7TsRp0BFwU6ELvVFEjU0YogG8S4GzMlcobwDHeA2J2mtUyPN1IFL4RcnizNvaUH8YfN6a3Hu7SBKvBMRCtpSXtRUYioshirHUWXceEYWkD+xaYp6eV1gI6VfQablfnV3jNrJqBnZsydAioHbSjcdN78aUGlQJqFpHsxd2zXOCC+8PsLJBaoVwKWoT6Yv5mh+X+c3SfBM0dGggyAgiAM8dclxDojoCDbHMQWvbo1sTdbzRnZ1nSHLQt5KLeSGtOVmVuYIhAqbT/LDmuiXq/a4tVLRCM8wi3i2SxUSdoH+yiAlP7cMpxXbKr2o/RLEdpb3AfqaA0B3gTaZayvvdXQjUwZbD1wYrScF9t7VqkNBw7R3NOWsiuQdBtIF3WmNRYAAx8qWMHAayW9x4EQemcrnsTnVduV3+Fd3VsIAs+upomBOm05ZakqwWDQ/4TullCRBIddvtNkrvUxRrWxYE3qhLsVZo3FtvZBbZDJrDZ8110h5nblmzCPJZWBl;4:QoBH5iuwT0h0igajpp76xczwSH4IUk06IkHHh7eFl0iO1KQDRnrGzIGQA6NaDSt16TqNYaH4enymoVDfA1LWBnBrrp9h67+wcTMpDv3cAc6vbr2n3wnN8ycw89hfF3JcSCU7P9GUn9ZgZpYSvcKx+2pSd664WVpGi8QMQSHHLBkdbKUtadpIxdBSH42ROVye8LbmPbD3geC+/pRNQOoN2p/KCjCiGJZKWRzTzVebe/gdxwpaxRvwJUadZhZtT/SxBg+1YEqAvChouyM27wzcbA==
X-Microsoft-Antispam-PRVS: <BN6PR03MB2628435B4046D9D224BFAC25EDA10@BN6PR03MB2628.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2628;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2628;
X-Forefront-PRVS: 06274D1C43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(51914003)(111735001)(199004)(189003)(11346002)(446003)(68736007)(52116002)(6116002)(23726003)(386003)(1076002)(478600001)(8676002)(6666003)(6916009)(2906002)(26005)(50466002)(47776003)(966005)(72206003)(105586002)(66066001)(8936002)(7736002)(3846002)(229853002)(7696005)(55016002)(25786009)(76176011)(476003)(316002)(5660300001)(53936002)(106356001)(230700001)(86362001)(486005)(81166006)(9686003)(81156014)(486005)(97736004)(50226002)(6506007)(305945005)(956004)(4326008)(33896004)(6306002)(186003)(16526019)(6246003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2628;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2628;23:yPWCHNzM4L77B12pk6ftp9JR558f7xWFG449tlq0o?=
 =?us-ascii?Q?oHVhkj6QU9jhCeD343OKzAluxMQrqJ3LqLPPklLd1dAn6CbtxyZ0DwLlA7J5?=
 =?us-ascii?Q?XBYauQMYyPQcEpBqr/lS2O+CydTMZ3+RHXPA2mobVRe/VCk7XP2LHWx8XlYJ?=
 =?us-ascii?Q?G2hbYJk7Vaorpv2YdNuuCFtyt0e8iw2tbTH6Wh5UBWfY83ywwkl9CYa3GJZc?=
 =?us-ascii?Q?mTq7aG6z7K3WZlxIRJu7gIesWnrGejTPN3P3EzVroeK2Hmdp1KygEzcVVtbI?=
 =?us-ascii?Q?AOlhx3V8cnrVtWEb07WrhedqNOrsLahaVGzEii+x5QcWai+O060TrYRNrGKK?=
 =?us-ascii?Q?WOexTzYChh18xpGKCrtq/dw6z4s6cDr3alNCLkP8BKrVRZTRxJ3Vk3Z7iXuJ?=
 =?us-ascii?Q?BSVCj04rTr48tu7o2S6pcbRDEx1S823+o1pNooj/SJkXSKVqx4rrl4Kl+oN1?=
 =?us-ascii?Q?s9xptEFW89hWAWj/QvTU0UWXJxm2YlLY5YRbS4G7A/UwF4BRm8Jw63FS3bc4?=
 =?us-ascii?Q?2V3k4rAz3oGfBmYESru9NjEKbty6M5OsxnshBrABUF9omRcqGV1Zjgqbk+9F?=
 =?us-ascii?Q?6fE6nDKDQXtYpxiXNgnPp/rKR6T6bglPEbBoTkeTd6YpOaCjMmREIYSTc4QK?=
 =?us-ascii?Q?csWGcXz6N9y90zBln9rU/Gj9r0RgVevjbcMcF/iV0szUW4keB5w8WJBN6De9?=
 =?us-ascii?Q?UddMcb05qxAELQ4Pk/iQ0QaH7XnmXqNoxoRnhS/6HL3myrAZz01sXqT4Sspy?=
 =?us-ascii?Q?/Dj2+Um5Yc3lk8W7hAO0NV9lcJt2Gzy3Zjn2WnFoGY8nuWqCtCa+C66vYiMz?=
 =?us-ascii?Q?LnxiKmr2LfTgE8Fuv2tD4Pxrx9KXegMbvWfEaVP1CdgphtwQanrVdZAJ4Zbb?=
 =?us-ascii?Q?d3zB0TRJgpHB6RDA9S7/OBI1yi5OOK0NBdMUR1yFkR4I0mHjZT3p8+9AaM87?=
 =?us-ascii?Q?8De415l3OHR8FD/SL0m35q7Bo8DLwC7W9MBzbbE6k/oeMO5dE4h/92hCkhiz?=
 =?us-ascii?Q?xbtTYWfpSLyp0gYnbw0p9cKAbAQYROiTzLTUPHBeAdqI1SdtKHRwyiCvZEE8?=
 =?us-ascii?Q?w5bppd9DQ2BLKZuGEtpRLouKE1X1EIUBGEa4BMn/4IAOg25fzowblj7GkZH+?=
 =?us-ascii?Q?GTSYsEmVhkMipxwb6rkECrgSYInJMEMCQDNrncZbqInWVLGcNHwMKbxU3jJ+?=
 =?us-ascii?Q?L2wnRyZSeD0ighnpsLfdgLPUyhOIu4PWDxCt5YdBOx52SIZIvE+KXFCl1TBn?=
 =?us-ascii?Q?0Vz1o21Tcq38Zvm77nfu2rcA4l/BOfbYXYpuSJfkvGnIXOXMEsd0gssuVcqZ?=
 =?us-ascii?Q?QD8jh86OQzQuQrw2JmszkE2aJbpe4ZFbfvQiH3VxYmWjW/JtLETxIj6a7wm2?=
 =?us-ascii?Q?krjFg=3D=3D?=
X-Microsoft-Antispam-Message-Info: lMxPHCMNIHg6Y1pbIlUx/0cwoMRTjfotRuYzmikZqafnMAKmfdEqB3wSi0xAueBZ2oGxX5+T/h4ohJq5ZtwEFAqobYQZszAXmdrs0rA+RTXIKOQAFGDc920877J8A+yumjzTioaz14Rdv7wksf9jR0wj8i+c1eG3+SHetRPYTaSCEJXUFJw3dOUZIr6xCVZM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;6:LrJZMUNUuk5LRC/Bdfre0j45rLbSZOkh4U1a7XUwTkCrTWSvkVquHxhbv0tSB05xNepvNm1h131Dt8xpXKzfaiIapy1YvXmWkdNqBc5Fw6ANp2dAmPT6GhP5E3+3BOy/LnTC4oFkzANam11eFvsJzErG//wQg2jw5p9iqGogDiv2a0vL82uwuoMfXqPUMYTXEOJOcBBYCbXshiG+gDwAFY54+jGn2zqEBMZKAAkOIrhb7tJPDrqgI1BIomeWiAJ/MRhk7yfdm5YZL/mxk7VzIznOIEnnnyqsQ1ABgonRObNIMduara5rHE1ctUVxYN60f0UNPDejOz1ITvnD1Ov7vbuz130wmE9Lt27QZ4JNQePV2zc4WyIb5dpbQxOTHyIuYnIsU21lQEHKBIhhoy8WSrFQGxQtEX17lvKBB+lQRD0TvYrNcNu1RzdAakdfJSKL8QfNunLMKuBcqjc1bYcOuA==;5:UrexN3aOHMFIPy8QPZqaPxD4FNXbqZp05SwUByaT53ulCpePjmWMh85ZvPu3P82BCVECYGFXeCU2b4Wr3UjKz2zfumC1In5uqXAoyXsJbWdIMvo4kg5QcR5To6+olhigG8R+RMTtQewab1XriyFQReGcJa+MmPd+52BI3r247yA=;24:LLS8iTF2yJkA1tVzuLGxJcTM4XU0PhKtY/D0fAHCZbzV5FsFV3N2QqtNclOHIiXLnsGrXY67mx2hHDbLOsSmK/5SQJyX0zKHvB8tjijIVlc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2628;7:sz60eaxKVh3GzSP+EBW9pYp8ft+sgiCYUr4PfF3etoPWYI83L6hYYlOJOSmvGxMplgHX1aW0BWe0UmZqEOeqK49/oozUvHXu+YMO9f5Wd8ZZz61jeCgCXVu4XaJNV3G7Tx6d8/NwZPjDA7dmFs0d7/mMKMIRME0pjyLZbXVhPpHiMJxgwug58ckrk7fqUq8kE/cd0Em7bA3GFyhcw/KL0kTCSdy0Wj336On5GtdKhU8MDp7cQhDqJDJjwNns+2WJ
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 03:19:46.7425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a51d54-276d-4c1b-4699-08d595ed17d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2628
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 29 Mar 2018 15:08:04 +0200 Andrew Lunn wrote:

> On Thu, Mar 29, 2018 at 04:42:40PM +0800, Jisheng Zhang wrote:
> > 
> > Change the entry name and move it to its alphabetical location.
> > We move to ARM/Synaptics instead of ARM/Marvell.  
> 
> Hi Jisheng
> 
> Please could you add some comments about this Marvell->Synaptics
> change.
> 
> Has Marvell sold the Berlin chip group to Synaptics?
> 

Thanks for the review. Synaptics has acquired the Multimedia Solutions
Business of Marvell.

https://www.synaptics.com/company/news/conexant-marvell

I have sent out v2.

Thanks
