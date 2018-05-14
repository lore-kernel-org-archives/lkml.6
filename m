Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeENVvg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:51:36 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45225 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeENVvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:51:33 -0400
X-Google-Smtp-Source: AB8JxZqN3Tt2LCeumKO0rDxoRcxjE3xl8tJnPSNj6jEuem1wEFgtIZPbRKRnPGFzSa/09L9NYYfzdkKnOeIe3coGs3c=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <567735cef55507a38120e30bea178980bb146313.1526173613.git.rgb@redhat.com>
References: <cover.1526173613.git.rgb@redhat.com> <567735cef55507a38120e30bea178980bb146313.1526173613.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 May 2018 17:51:31 -0400
Message-ID: <CAHC9VhT+9xV-EdChmB4b7pFtNWz2BrEsqWEzqfNSdKg8yj08Jg@mail.gmail.com>
Subject: Re: [PATCH ghak81 RFC V2 4/5] audit: use inline function to set audit context
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 9:58 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Recognizing that the audit context is an internal audit value, use an
> access function to set the audit context pointer for the task
> rather than reaching directly into the task struct to set it.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h | 6 ++++++
>  kernel/auditsc.c      | 7 +++----
>  kernel/fork.c         | 2 +-
>  3 files changed, 10 insertions(+), 5 deletions(-)

Merged with some minor fuzz.

-- 
paul moore
www.paul-moore.com
