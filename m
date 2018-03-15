Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeCOXko (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:40:44 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:48062 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbeCOXkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:40:42 -0400
Subject: Re: [PATCH v4 00/10] x86/microcode/AMD: Check microcode file sanity
 before loading it
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <9964a6cf-00be-78ea-cc1e-7f7062716fce@maciej.szmigiero.name>
 <20180315232306.GA31610@pd.tnic>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <ec44a74e-9017-b6bf-7397-862eca48026e@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:40:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315232306.GA31610@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.2018 00:23, Borislav Petkov wrote:
> On Fri, Mar 16, 2018 at 12:07:34AM +0100, Maciej S. Szmigiero wrote:
>> Currently, it is very easy to make the AMD microcode update driver crash
>> or spin on a malformed microcode container file since it does very little
>> consistency checking on data loaded from such file.
> 
> Ok, a couple of tips for the next time:
> 
> * please send your reworked patchset for review after review of your
> current patchset has been completed. We normally send patchsets once a
> week. You've sent yours two days after and that's kinda too fast. I'm
> sure you can imagine reviewers have other work to do too.
>
> So please be patient before resending next time.
> 
> If in doubt, the whole process is documented in Documentation/process/ -
> might wanna skim through it.
I thought the one week absolute minimum resend time is for the case that
there are no comments to a patch, or, more generally, when there is no
action and not for "normal process" respins.

submitting-patches.rst says:
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> one week before resubmitting or pinging reviewers - possibly longer during
> busy times like merge windows.

But I will wait a week now for respins if you say so.

> * when sending your patchset, make sure all mails are sent as a reply to
> the 0/N message.
> 
> Your 0/N has:
> 
> Message-ID: <9964a6cf-00be-78ea-cc1e-7f7062716fce@maciej.szmigiero.name>
> 
> but your 1/N has
> 
> References: <cover.1521150415.git.mail@maciej.szmigiero.name>
> 
> so something went wrong there. Normally git send-email does this
> correctly.

I've copied these messages to my mailbox first and sent them from there,
so that must have overwritten the message IDs.
Will submit them from git-send-email the next time.

> Thx.

Thanks,
Maciej
