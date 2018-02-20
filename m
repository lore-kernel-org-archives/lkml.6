Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBTVWn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:22:43 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:46191 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTVWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:22:41 -0500
X-Google-Smtp-Source: AH8x224cdmj6nWLua1AZVhEqSEhYnxaNNousl5vgAFWNpSaOzKsO+zDl7ACadp85wLfhO7ubnhz/+nRuGVD5IAdXQYI=
MIME-Version: 1.0
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com> <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk>
In-Reply-To: <20180220211849.fqjb6rdmypl6opir@agluck-desk>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 20 Feb 2018 21:22:29 +0000
Message-ID: <CACdnJusL1Vj_rvhZY+0_KZkrk=fwnQcr1y+vxOBmUXa4xdHHsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: tony.luck@intel.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        joe.konno@linux.intel.com, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, matthew.garrett@nebula.com,
        Jeremy Kerr <jk@ozlabs.org>, ak@linux.intel.com, pjones@redhat.com,
        luto@kernel.org,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 1:18 PM Luck, Tony <tony.luck@intel.com> wrote:

> Does this rate an exception to the "don't break userspace" for a security
issue?

To be clear, when you say "security" is this in reference to it being a
denial of service, or are you worried about other interactions that may
cause wider security issues?
