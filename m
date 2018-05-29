Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755274AbeE2H6P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:58:15 -0400
Received: from zoot.epublica.de ([78.46.103.157]:40666 "EHLO zoot.epublica.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755186AbeE2H6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:58:03 -0400
Subject: Re: [PATCH] HID: Add support for 146b:0902 Bigben Interactive Kids'
 gamepad
From: Hanno Zulla <abos@hanno.de>
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <31245206-038e-4a5b-a1a1-8877463556a7@hanno.de>
 <CAEc3jaB7jPJ_xa5rFrunwcPgkG9VrCdJSbb=BrQsHKxrO9AixQ@mail.gmail.com>
 <729f18bc-65b7-9bfd-50ed-fbb1f168500d@hanno.de>
Message-ID: <b69c7f7c-2d29-3360-8b65-4db717403899@hanno.de>
Date: Tue, 29 May 2018 09:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <729f18bc-65b7-9bfd-50ed-fbb1f168500d@hanno.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-LU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> not fully adhere to the gamepad spec (e.g. xpad.c also doesn't map my> XBox-Controller's D-Pad to NORTH/EAST/SOUTH/WEST but instead to HAT0
in> the same way as this device does).

Sorry, that was wrong. I meant BTN_DPAD_* instead of HAT0, despite them
being digital buttons.

Kind regards,

Hanno
