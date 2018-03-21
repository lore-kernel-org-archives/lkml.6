Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbeCUJk1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:40:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751405AbeCUJkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:40:25 -0400
Subject: Re: [RFC PATCH 0/3] Salted build ids via linker sections
To: Laura Abbott <labbott@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        mjw@fedoraproject.org, "H . J . Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org,
        Cary Coutant <ccoutant@gmail.com>
References: <20180321014635.29113-1-labbott@redhat.com>
From: Nick Clifton <nickc@redhat.com>
Organization: Red Hat
Message-ID: <00fd0e10-2c64-7a19-dd01-ec1a4440933d@redhat.com>
Date: Wed, 21 Mar 2018 09:40:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321014635.29113-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

> This is an implementation of the counter proposal. If an environment variable
> is set, that value gets added as a .comment section to the necessary binaries.

This is not really my purview but ... can I just say that I really do not like
using environment variables to control build behaviour.  It makes reproducing a
build much harder.  Especially when you are trying to reproduce a bug report from
a user who does not even know that the environment variable exits.

Cheers
  Nick
