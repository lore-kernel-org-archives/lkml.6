Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeFAP4Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:56:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43834 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbeFAP4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:56:18 -0400
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
To: Konstantin Khlebnikov <koct9i@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
 <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
 <87h8oqhagl.fsf@xmission.com>
 <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
 <e1402871-77a5-6a0f-a75c-ccad77b93f49@oracle.com>
 <778ab3d0-b6bc-fdb5-669a-40222e5020d4@yandex-team.ru>
 <e3a1076d-cfd7-a034-dd08-2d74fbf751f3@oracle.com>
 <3e2c285a-1bf8-f71d-1b74-4d6465c29a54@yandex-team.ru>
 <3bdd6b27-0a46-5802-8671-07268cecc1c7@oracle.com>
 <87po1bd7ky.fsf@xmission.com>
 <CALYGNiPyjJQ2dZHtF+Ug5TFjEcK2O9anLDDDG0JftXtykPAoEg@mail.gmail.com>
From: NAGARATHNAM MUTHUSAMY <nagarathnam.muthusamy@oracle.com>
Organization: Oracle Corporation
Message-ID: <2cc8a788-56ec-8e30-be04-d5d0e0791f90@oracle.com>
Date: Fri, 1 Jun 2018 08:55:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CALYGNiPyjJQ2dZHtF+Ug5TFjEcK2O9anLDDDG0JftXtykPAoEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8911 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=57 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=935
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806010185
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2018 11:58 PM, Konstantin Khlebnikov wrote:
> On Thu, May 31, 2018 at 9:05 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>>
>>> Ping? Any additional comments on this patch?
>> Konstantin's v5 no.
>>
>>    I am uncomfortable with unnecessary flexibility.  I don't want to
>>    encourage the increased usage of pids to identify namespaces.  I saw
>>    no arguments in favor of pids to identify namespaces from Konstantin.
>>
>> Your v4 updated to reflect Andrew Morton's concerns in the changelog
>> yes.
> Ok, whatever. If I the only blocker then let it be v4 design.

Thanks! I will resend the V4 patch with a plain text man page for 
translate_pid.

Thanks,
Nagarathnam.
>
>> Eric
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-api" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
