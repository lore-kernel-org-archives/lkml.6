Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935610AbeCHIEg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 03:04:36 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36762 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935381AbeCHIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 03:04:33 -0500
X-Google-Smtp-Source: AG47ELu5kOelHZWUTqx06kxupQ3UK6Vz2AP7OZFoweLh1IitEEegQKq1/zijaGs9AnYq1Fj0hPyZVw==
Subject: Re: [PATCH 0/6] lib/scatterlist: Small SGL tidy
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
 <1520447880.2890.43.camel@wdc.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <28964dac-ed10-dfac-4c7f-bc2632479d79@ursulin.net>
Date: Thu, 8 Mar 2018 08:04:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520447880.2890.43.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/03/18 18:38, Bart Van Assche wrote:
> On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
>> I spotted a few small issues in the recent added SGL code so am sending some
>> patches to tidy this.
> 
> Can you send the fixes as a separate series and keep the rework / behavior changes
> for later such that Jens can queue the fixes for kernel v4.16?

Yes of course. But which ones you consider rework and behaviour changes? 
To me all look like fixes / cleanups. (Last patch in the series needs a 
fix/respin btw)

Regards,

Tvrtko
