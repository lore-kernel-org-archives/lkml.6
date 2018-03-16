Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeCPOAd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:00:33 -0400
Received: from ozlabs.org ([103.22.144.67]:45121 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbeCPOAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:00:32 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: Re: [RESEND PATCH] Input: joystick/analog - Use get_cycles() on PPC
In-Reply-To: <20180314163913.GC18065@dtor-ws>
References: <20180314111752.1748-1-mpe@ellerman.id.au> <20180314163913.GC18065@dtor-ws>
Date: Sat, 17 Mar 2018 01:00:29 +1100
Message-ID: <87woycglxe.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> On Wed, Mar 14, 2018 at 10:17:52PM +1100, Michael Ellerman wrote:
>> The analog joystick driver spits a warning at us:
>> 
>>   drivers/input/joystick/analog.c:176:2: warning: #warning Precise timer
>>   not defined for this architecture.
>> 
>> PPC has get_cycles() so use that.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Applied, thank you.

Thanks.

cheers
