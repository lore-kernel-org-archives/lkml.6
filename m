Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeBTMMM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 07:12:12 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44323 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeBTMML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 07:12:11 -0500
X-Google-Smtp-Source: AH8x227RI/5Mp1kyd0b9Z7qiyZSPVFXf1wJ/BMKeeVghBMePLNP+qwAI9EaErxhmWBG5AhyByV0IiQ==
Subject: Re: [PATCH] regulator: core: Handle PM_SUSPEND_TO_IDLE
 suspend_state_t
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20180218170424.11976-1-hdegoede@redhat.com>
 <20180219113444.GA32761@sirena.org.uk>
 <5486ab34-4e5b-e2d5-9475-4d7e24a0cda6@redhat.com>
 <20180220114759.GB6378@sirena.org.uk>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <066afd48-896f-b8fa-0bc0-7e3b0b76e33b@redhat.com>
Date: Tue, 20 Feb 2018 13:12:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220114759.GB6378@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-02-18 12:47, Mark Brown wrote:
> On Mon, Feb 19, 2018 at 09:59:13PM +0100, Hans de Goede wrote:
>> On 19-02-18 12:34, Mark Brown wrote:
> 
>> There are multiple callers of regulator_get_suspend_state() in
>> drivers/regulator/core.c, I assume you refer to this commit:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/regulator/core.c?id=57a0dd187956ea04870f4bbbf25a63c425ee7cad
> 
> No, he sent a second fix which isn't in Linus' tree yet, see my -next.

I might just be looking at the wrong place and if so I'm sorry, but I
don't see any (additional) fixes related to this here:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/log/drivers/regulator?h=for-next

Regards,

Hans
