Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754734AbeDTMCj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:02:39 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45046 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:02:37 -0400
X-Google-Smtp-Source: AIpwx4/16NIAX84v1YzVVlLbvN2Ux86xyxL3Q/x9EBlb9b/Y3wmdBnCOciVU+rv9DNUbSkgSiJD/zlwINhQaJiwE3xk=
MIME-Version: 1.0
In-Reply-To: <20180420104126.GA20680@infradead.org>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
 <b80a4634cf77694dd90d510175a6633a93ea639d.1524143428.git.greentime@andestech.com>
 <20180420104126.GA20680@infradead.org>
From: Greentime Hu <green.hu@gmail.com>
Date: Fri, 20 Apr 2018 20:01:56 +0800
Message-ID: <CAEbi=3dYaax4bpuzDxMQwnM78yN3uzFOHK-dVUuWxu6WRJO+PQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] nds32: Fix the symbols undefined issue by exporting them.
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Greentime <greentime@andestech.com>,
        Guenter Roeck <private@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-20 18:41 GMT+08:00 Christoph Hellwig <hch@infradead.org>:
>> +++ b/arch/nds32/kernel/stacktrace.c
>> @@ -9,6 +9,7 @@ void save_stack_trace(struct stack_trace *trace)
>>  {
>>       save_stack_trace_tsk(current, trace);
>>  }
>> +EXPORT_SYMBOL(save_stack_trace);
>
> All other architectures use EXPORT_SYMBOL_GPL here.

Thank you.
I will update it and other architectures also export save_stack_trace_tsk.
I will export it too.
