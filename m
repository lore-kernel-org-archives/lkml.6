Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeEOSZR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:25:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52916 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753048AbeEOSZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:25:05 -0400
X-Google-Smtp-Source: AB8JxZpoewNry4OrYFFxrGuQTXcacvl8J6wg5SlfySTSrcgjYZYqY6Z1MZG2NmtbvwhGeUHSe3VFkQ==
Subject: Re: [PATCH 00/14] Modify action API for implementing lockless actions
To: Vlad Buslov <vladbu@mellanox.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, pablo@netfilter.org, kadlec@blackhole.kfki.hu,
        fw@strlen.de, ast@kernel.org, daniel@iogearbox.net,
        edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com>
 <23f37e5a-dd30-0ad3-a5ab-df22bf0ad7f9@mojatatu.com>
 <vbfo9him0d7.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <97ccb118-a3dc-6eb0-b127-9c04adf9e2fd@mojatatu.com>
Date: Tue, 15 May 2018 14:25:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <vbfo9him0d7.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/18 04:46 PM, Vlad Buslov wrote:
> 
> On Mon 14 May 2018 at 18:03, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>> On 14/05/18 10:27 AM, Vlad Buslov wrote:


> Hello Jamal,
> 
> I'm trying to run tdc, but keep getting following error even on clean
> branch without my patches:

Vlad, not sure if you saw my email:
Apply Roman's patch and try again

https://marc.info/?l=linux-netdev&m=152639369112020&w=2

cheers,
jamal
