Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeCNTLz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:11:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751394AbeCNTLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:11:54 -0400
Subject: Re: [PATCH v2 0/2] clk: aspeed: Fix is_enabled and prevent reset if
 clock enabled
To: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, joel@jms.id.au, mturquette@baylibre.com,
        mine260309@gmail.com, ryan_chen@aspeedtech.com
References: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
 <152064250369.205167.5918389143946901453@swboyd.mtv.corp.google.com>
From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 14:11:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152064250369.205167.5918389143946901453@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031419-0020-0000-0000-00000D975CA5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003040; UDB=6.00510433; IPR=6.00782370;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 19:11:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031419-0021-0000-0000-0000607EB4F7
Message-Id: <b137a12a-82d9-2e5d-8408-f743162d1628@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140209
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2018 06:41 PM, Stephen Boyd wrote:
> Quoting Eddie James (2018-03-08 12:57:18)
>> Here are two fixes for the Aspeed clock driver. The first fixes the is_enabled
>> clock function to account for different clock gates getting disabled with
>> either 0s or 1s. The second patch addresses some issue found with the LPC
>> controller clock if it gets reset while the clock is enabled, which it is by
>> default. Thanks to Lei Yu for tracking down the LPC issue.
>>
> Can you please add some "Fixes:" tags to these patches? Or just indicate
> the tags and I can pick them up. If it doesn't happen, I'll just apply
> these early next week.

Sure, sorry for the late response...

Patch 1 fixes 6671507f0fbd582b4003f837ab791d03ade8e0f4
Patch 2 fixes 15ed8ce5f84e2b3718690915dbee12ebd497dc0f

Thanks!
Eddie

>
