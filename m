Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeBZQNP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:13:15 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:38725 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeBZQNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:13:10 -0500
X-Google-Smtp-Source: AG47ELtVRFXr262nTiYn0udQkK3G8Ua/l9NNz65aeUYt8dnhUORNKWi/5EDg7D/H/sM5Wq6IJxVee2Jgy/VKJGLdBr0=
MIME-Version: 1.0
In-Reply-To: <30581e0c-88f0-8a8e-a620-e5b20027175b@redhat.com>
References: <1519436776-2987-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFxeFRsDB+DaDW+E1daFRgk4Ccy=Tmt7cPn2A-uCmqW1iw@mail.gmail.com> <30581e0c-88f0-8a8e-a620-e5b20027175b@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 26 Feb 2018 08:13:09 -0800
X-Google-Sender-Auth: 7qxKl4dq4dCQTM20nbyM4kRoJYU
Message-ID: <CA+55aFzuOAn4d4gkvXNAfNnRwgsAa3G4H9HJNUfSxDJ0Wetagw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.16-rc3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 12:28 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> I rebased to correct a "Fixes" tag that pointed to the wrong commit.
> This: https://marc.info/?l=kvm&m=151943277910352&w=2 is the mail that
> pointed out the right commit, and you can see that those 28 commits have
> times that are clustered five minutes after that mail.
>
> The SEV patches indeed have been committed about half an hour before
> sending the PULL request, because no one outside AMD has all the
> hardware and code to test them.  Half an hour is about the time it takes
> me to do the final smoke test before sending a pull request.

So this is the kind of information I'd like to see in the pull
request, so that I don't have to wonder why something went wrong.

I'll pull again after I've had my morning coffee.

              Linus
