Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbeBUHpp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 02:45:45 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:42227 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeBUHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 02:45:43 -0500
X-Google-Smtp-Source: AH8x227pvq2PWcIUnlVwjwaO/4Yac58svGVqletwnwvv+GDgSoGF8prB2IqsqZJfAp8i6nBbWqmBciOxh06CIGlLF+w=
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <20180220230136.GD170644@devbig577.frc2.facebook.com>
References: <CAKgNAkgEa9ZEHzoRWv7Y71eFVuFsy8Z4zSazZv9u7NRrx3xG9Q@mail.gmail.com>
 <20180220193547.GB170644@devbig577.frc2.facebook.com> <20180220230136.GD170644@devbig577.frc2.facebook.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Wed, 21 Feb 2018 08:45:21 +0100
Message-ID: <CAKgNAkhMqq=VRKrLp89f5RR_gmsLSrd5W+qN8jv5C_ZVwzFs_Q@mail.gmail.com>
Subject: Re: A "domain invalid" cgroup *can* sometimes have member tasks
To: Tejun Heo <tj@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tehjun,

On 21 February 2018 at 00:01, Tejun Heo <tj@kernel.org> wrote:
> On Tue, Feb 20, 2018 at 11:35:47AM -0800, Tejun Heo wrote:
>> Hmm... nr_populated_domain_children check should have caught that
>> condition and rejected it.  Will look into what's going on.
>
> Ah, okay, I was special-casing the first level children case too
> early.  If you nest the test case by one more level, it fails as
> intended.  I'll fix the checks.

Thanks for looking into this so quickly! Please CC me on the patch.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
