Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756615AbeEIOMz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:12:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56684 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756555AbeEIOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:12:50 -0400
Subject: Re: [PATCH V3 1/1] PCI/AER: add pcie TLP header information in the
 tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mr.nuke.me@gmail.com
References: <1525820696-31967-1-git-send-email-thomas.tai@oracle.com>
 <1525820696-31967-2-git-send-email-thomas.tai@oracle.com>
 <20180509083814.149e8d8f@gandalf.local.home>
From: Thomas Tai <thomas.tai@oracle.com>
Organization: Oracle Corporation
Message-ID: <f3248367-f702-2dba-5406-a1ba275e198a@oracle.com>
Date: Wed, 9 May 2018 10:12:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509083814.149e8d8f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=754
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-05-09 08:38 AM, Steven Rostedt wrote:
> On Tue,  8 May 2018 19:04:56 -0400
> Thomas Tai <thomas.tai@oracle.com> wrote:
> 
>> When a PCIe AER occurs, the TLP header information is
>> printed in the kernel message but it is missing from
>> the tracepoint. A userspace program can use this information
>> in the tracepoint to better analyze problems.
>>
>> To enable the tracepoint:
>> echo 1 > /sys/kernel/debug/tracing/events/ras/aer_event/enable
>>
>> Example tracepoint output:
>> cat /sys/kernel/debug/tracing/trace
>> aer_event: 0000:01:00.0
>> PCIe Bus Error: severity=Uncorrected, non-fatal, Completer Abort
>> TLP Header={0x0,0x1,0x2,0x3}
>>
>> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
>> ---
> 
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thank you very much Steven.

-Thomas

> 
> -- Steve
> 
