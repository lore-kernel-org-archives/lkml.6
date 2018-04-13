Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeDMNer (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:34:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750980AbeDMNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:34:46 -0400
Subject: Re: [PATCH v9 00/24] Speculative page faults
To: Michal Hocko <mhocko@kernel.org>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
        dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
        sergey.senozhatsky.work@gmail.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
        npiggin@gmail.com, bsingharora@gmail.com,
        Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180314131118.GC23100@dhcp22.suse.cz>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 13 Apr 2018 15:34:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180314131118.GC23100@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041313-0044-0000-0000-00000546F156
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041313-0045-0000-0000-000028873141
Message-Id: <78f7f2c0-40e6-f080-e531-70305530f1ce@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130126
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2018 14:11, Michal Hocko wrote:
> On Tue 13-03-18 18:59:30, Laurent Dufour wrote:
>> Changes since v8:
>>  - Don't check PMD when locking the pte when THP is disabled
>>    Thanks to Daniel Jordan for reporting this.
>>  - Rebase on 4.16
> 
> Is this really worth reposting the whole pile? I mean this is at v9,
> each doing little changes. It is quite tiresome to barely get to a
> bookmarked version just to find out that there are 2 new versions out.
> 
> I am sorry to be grumpy and I can understand some frustration it doesn't
> move forward that easilly but this is a _big_ change. We should start
> with a real high level review rather than doing small changes here and
> there and reach v20 quickly.

I know this would mean v10, but there has been a bunch of reviews from David
Rientjes and Jerome Glisse, and I had to make many changes to address them.
So I think this is time to push a v10.

If you have already started a review of this v9 series, please send me your
remarks so that I can compile them in this v10 asap.

Thanks,
Laurent.
