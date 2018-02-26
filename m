Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeBZI2g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:28:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752956AbeBZI2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:28:30 -0500
Subject: Re: [GIT PULL] KVM changes for 4.16-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
References: <1519436776-2987-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFxeFRsDB+DaDW+E1daFRgk4Ccy=Tmt7cPn2A-uCmqW1iw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30581e0c-88f0-8a8e-a620-e5b20027175b@redhat.com>
Date: Mon, 26 Feb 2018 09:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFxeFRsDB+DaDW+E1daFRgk4Ccy=Tmt7cPn2A-uCmqW1iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2018 01:05, Linus Torvalds wrote:
> On Fri, Feb 23, 2018 at 5:46 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
> 
> This has 28 fixes that were committed one hour before you sent this email.
> 
> I pulled, but I think I'm going to unpull, just because I want an
> explanation of how that could possibly have had sufficient testing for
> the upcoming rc?

I rebased to correct a "Fixes" tag that pointed to the wrong commit.
This: https://marc.info/?l=kvm&m=151943277910352&w=2 is the mail that
pointed out the right commit, and you can see that those 28 commits have
times that are clustered five minutes after that mail.

The SEV patches indeed have been committed about half an hour before
sending the PULL request, because no one outside AMD has all the
hardware and code to test them.  Half an hour is about the time it takes
me to do the final smoke test before sending a pull request.

Paolo
