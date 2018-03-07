Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbeCGEKo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 23:10:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753940AbeCGEKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 23:10:31 -0500
Subject: Re: [PATCH 2/2] trace_uprobe: Simplify probes_seq_show()
To: Kees Cook <keescook@chromium.org>
Cc: wangnan0 <wangnan0@huawei.com>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180206093430.7550-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180206093430.7550-2-ravi.bangoria@linux.vnet.ibm.com>
 <CAGXu5jLT+0=eSV-o8Ogd_a1krM6nppvqQ_fqn8Rn=ArPRwq7Ow@mail.gmail.com>
 <536fd857-2ee9-ef9c-4cc5-588ae1a07355@linux.vnet.ibm.com>
 <8b812c4f-dfd8-928e-d5dd-f65679d0a88e@linux.vnet.ibm.com>
 <CAGXu5jLhTdkyeJv6v6hf-qB6U3eZBFUq0KrT9CVgfSTZa1yMmA@mail.gmail.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 7 Mar 2018 09:42:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLhTdkyeJv6v6hf-qB6U3eZBFUq0KrT9CVgfSTZa1yMmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030704-0008-0000-0000-000004D8BA32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030704-0009-0000-0000-00001E6BD374
Message-Id: <2aa430ae-9d75-a6e4-8976-fd3cb63c35d0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070046
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/07/2018 03:34 AM, Kees Cook wrote:
> On Tue, Mar 6, 2018 at 12:12 AM, Ravi Bangoria
> <ravi.bangoria@linux.vnet.ibm.com> wrote:
>>
>> On 02/08/2018 09:13 AM, Ravi Bangoria wrote:
>>> Wang, ping :)
>>>
>>> Kees, I don't hear back from Wang and no one has reported any issues with
>>> the patches yet. Can I have your Acked-by?
> I didn't see a v2 of these patches with the output fixed?

Kees, I didn't send v2 because those 0s seems unnecessary to me.

Please let me know if you still wants to show them. Will re-spin :)

Thanks,
Ravi

PS: Changing Masami's email address in cc.
