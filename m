Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752865AbeCPOJU convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:09:20 -0400
Received: from ozlabs.org ([103.22.144.67]:57249 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752843AbeCPOIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:08:53 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/21] powerpc: Mark both tmp variables as unused
In-Reply-To: <3f881ec2-eb0f-77e6-f1c5-95530b8f84ad@c-s.fr>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-5-malat@debian.org> <3f881ec2-eb0f-77e6-f1c5-95530b8f84ad@c-s.fr>
Date: Sat, 17 Mar 2018 01:08:49 +1100
Message-ID: <87tvtgglji.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 25/02/2018 à 18:22, Mathieu Malaterre a écrit :
>> Since the value of `tmp` is never intended to be read, declare both `tmp`
>> variables as unused. Fix warning (treated as error in W=1):
>
> What about using fault_in_pages_readable() instead ?

Yeah that looks like it would work.

I'd be happy to take a tested patch :D

cheers
