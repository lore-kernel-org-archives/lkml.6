Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeAaT3G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 14:29:06 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:37251 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeAaT3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 14:29:04 -0500
X-Google-Smtp-Source: AH8x2255SvdywkdYUCXJQ/fupW1780SJ0s4qYdb8ufIi6xZxNFIBYY1/q38ae8JZZVQDTmFADpBpQh8UqajqhIXcPq0=
MIME-Version: 1.0
In-Reply-To: <1517420549.3937.67.camel@HansenPartnership.com>
References: <1517420549.3937.67.camel@HansenPartnership.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jan 2018 11:29:03 -0800
X-Google-Sender-Auth: nJTyhWWnwzrH3oh2LvauDjSGNYY
Message-ID: <CA+55aFy4YfNEKiDipUXM_KYR5wen-8hmOp7B7t+=boq14EgdJA@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 4.14+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 9:42 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

Ok, now I did indeed get that

  gpg: Can't check signature: unknown pubkey algorithm

because of your fancy new key. But making git use gpg2 indeed fixes
it, since I have a recent enough version.

Let's see if anybody else even notices. I don't think lots of people
look at the signatures.

              Linus
