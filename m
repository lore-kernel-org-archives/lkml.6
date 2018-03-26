Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeCZPE5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 11:04:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41501 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeCZPE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 11:04:56 -0400
X-Google-Smtp-Source: AG47ELvxyfxGiEyhlWtW8l9utxMS8z3/Qe1OJtgeTW6NCvtMiz5N1TVzUogO0lYzxeef4Cw2SMyBhg==
Date: Mon, 26 Mar 2018 23:04:47 +0800
From: Wei Yang <richard.weiyang@gmail.com>
To: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, prudo@linux.vnet.ibm.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        takahiro.akashi@linaro.org, ebiederm@xmission.com, dyoung@redhat.com,
        vgoyal@redhat.com
Subject: Re: [PATCH 1/2] resource: add walk_system_ram_res_rev()
Message-ID: <20180326150447.GA78252@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20180322033722.9279-1-bhe@redhat.com>
 <20180322033722.9279-2-bhe@redhat.com>
 <20180322152929.9b421af2f66cc819ad691207@linux-foundation.org>
 <20180323005845.GA25740@localhost.localdomain>
 <20180322190606.859a0f1c7e2d1b2958daeb9f@linux-foundation.org>
 <20180323031013.GB11150@localhost.localdomain>
 <20180323130620.7d60fc442463ed5c21898387@linux-foundation.org>
 <20180324133330.GD25740@localhost.localdomain>
 <20180324161343.GA58414@WeideMacBook-Pro.local>
 <20180326143016.GE25740@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326143016.GE25740@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:30:16PM +0800, Baoquan He wrote:
>Hi Wei Yang,
>
>On 03/25/18 at 12:13am, Wei Yang wrote:
>> On Sat, Mar 24, 2018 at 09:33:30PM +0800, Baoquan He wrote:
>> >> 
>> >> Yes.  That sounds perfectly acceptable.
>> >> 
>> >> It would be interesting to see what this approach looks like, if you
>> >> have time to toss something together?
>> >
>> >OK, will make patches for reviewing. Thanks!
>> 
>> Hi, Baoquan, Andrew
>> 
>> I have come up with an implementation for top-down search the ram resources.
>> Hope this would meet your need.
>
>Thanks for telling and your effort. Glad to know
>I am not the only buyer of walk_system_ram_res_rev. I am fine with other
>ways to make it, people can compare them and know which one is better.
>I am working to use the list_head instead, the doubly linked list way
>as Andrew suggested. Andrew and other people can help make a choice. It
>won't be long.
>

Sure,

Look forward your approach.

>Thanks
>Baoquan
>

-- 
Wei Yang
Help you, Help me
