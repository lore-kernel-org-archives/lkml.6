Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeDPJ4G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:56:06 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:38621 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753405AbeDPJ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:56:04 -0400
X-Google-Smtp-Source: AIpwx4/Ihn28D2ZUZHEA/qTSkG9EJNJIdbNojSLQO7NB8VZ2S6QI/YgbMHDeuitgtdM0pNu7kZe5sYxpUcdRx26V5/Y=
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1804161148370.28129@cbobk.fhfr.pm>
References: <20180411094953.12053-1-rombert@apache.org> <nycvar.YFH.7.76.1804161148370.28129@cbobk.fhfr.pm>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 16 Apr 2018 11:56:03 +0200
Message-ID: <CAO-hwJK9+C-9oucz4QdHp-51rTaTHQVp-KB3ORRFQ0oXXQ8ksA@mail.gmail.com>
Subject: Re: [PATCH v5] Fix modifier keys for Redragon Asura Keyboard
To: Jiri Kosina <jikos@kernel.org>
Cc: Robert Munteanu <rombert@apache.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 11:49 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 11 Apr 2018, Robert Munteanu wrote:
>
>> Changelog:
>>
>> - v2: modifier keys work, some combinations are still troublesome
>> - v3: style cleanup, rebase on top of 4.14
>> - v4: remove most debugging calls, make init info useful for user,
>>   rebased on top of 4.15
>> - v5: fix the HID descriptor as suggested by Benjamin Tissoires,
>>   use existing USB vendor id, update comment style, add SPDX
>>   license identifier, rename to hid-redragon, stop registering
>>   two input devices, rebased on top of 4.16
>
> This should contain the text that goes directly into the git commit
> changelog, therefore should instead contain something like "This adds a
> news driver for HW XX, that needs a specialized driver bacuse .... and
> things to specifically point out in implementation are ....".
>
> Could you please provide that, so that I can commit it?

Jiri, please hold off, I have a few comments while quickly reviewing the patch.

Cheers,
Benjamin

>
> Thanks.
>
> --
> Jiri Kosina
> SUSE Labs
>
