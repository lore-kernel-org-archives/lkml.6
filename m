Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeEQMLE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:11:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50377 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeEQMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:11:00 -0400
X-Google-Smtp-Source: AB8JxZrhh1TPhFXhvsUjjpuX3fFTfc7UYcJt9BIL4tGCnXMsYCY1vSpqEbLMXnYp+wwEjBaHoe0Bdg==
Subject: Re: [PATCH v3 1/2] media: rc: introduce BPF_PROG_RAWIR_EVENT
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        Matthias Reichl <hias@horus.com>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Y Song <ys114321@gmail.com>
References: <cover.1526504511.git.sean@mess.org>
 <92785c791057185fa5691f78cecfa4beae7fc336.1526504511.git.sean@mess.org>
From: Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <592262ad-e92f-2b53-f6bb-086257c21db0@netronome.com>
Date: Thu, 17 May 2018 13:10:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <92785c791057185fa5691f78cecfa4beae7fc336.1526504511.git.sean@mess.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-16 22:04 UTC+0100 ~ Sean Young <sean@mess.org>
> Add support for BPF_PROG_RAWIR_EVENT. This type of BPF program can call
> rc_keydown() to reported decoded IR scancodes, or rc_repeat() to report
> that the last key should be repeated.
> 
> The bpf program can be attached to using the bpf(BPF_PROG_ATTACH) syscall;
> the target_fd must be the /dev/lircN device.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/media/rc/Kconfig           |  13 ++
>  drivers/media/rc/Makefile          |   1 +
>  drivers/media/rc/bpf-rawir-event.c | 363 +++++++++++++++++++++++++++++
>  drivers/media/rc/lirc_dev.c        |  24 ++
>  drivers/media/rc/rc-core-priv.h    |  24 ++
>  drivers/media/rc/rc-ir-raw.c       |  14 +-
>  include/linux/bpf_rcdev.h          |  30 +++
>  include/linux/bpf_types.h          |   3 +
>  include/uapi/linux/bpf.h           |  55 ++++-
>  kernel/bpf/syscall.c               |   7 +
>  10 files changed, 531 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/media/rc/bpf-rawir-event.c
>  create mode 100644 include/linux/bpf_rcdev.h
> 

[...]

Hi Sean,

Please find below some nitpicks on the documentation for the two helpers.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index d94d333a8225..243e141e8a5b 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

[...]

> @@ -1902,6 +1904,35 @@ union bpf_attr {
>   *		egress otherwise). This is the only flag supported for now.
>   *	Return
>   *		**SK_PASS** on success, or **SK_DROP** on error.
> + *
> + * int bpf_rc_keydown(void *ctx, u32 protocol, u32 scancode, u32 toggle)
> + *	Description
> + *		Report decoded scancode with toggle value. For use in
> + *		BPF_PROG_TYPE_RAWIR_EVENT, to report a successfully

Could you please use bold RST markup for constants and function names?
Typically for BPF_PROG_TYPE_RAWIR_EVENT here and the enum below.

> + *		decoded scancode. This is will generate a keydown event,

s/This is will/This will/?

> + *		and a keyup event once the scancode is no longer repeated.
> + *
> + *		*ctx* pointer to bpf_rawir_event, *protocol* is decoded
> + *		protocol (see RC_PROTO_* enum).

This documentation is intended to be compiled as a man page. Could you
please use a complete sentence here?
Also, this could do with additional markup as well: **struct
bpf_rawir_event**.

> + *
> + *		Some protocols include a toggle bit, in case the button
> + *		was released and pressed again between consecutive scancodes,
> + *		copy this bit into *toggle* if it exists, else set to 0.
> + *
> + *     Return

The "Return" lines here and in the second helper use space indent
instead as tabs (as all other lines do). Would you mind fixing it for
consistency?

> + *		Always return 0 (for now)

Other helpers use just "0" in that case, but I do not really mind.
Out of curiosity, do you have anything specific in mind for changing the
return value here in the future?

> + *
> + * int bpf_rc_repeat(void *ctx)
> + *	Description
> + *		Repeat the last decoded scancode; some IR protocols like
> + *		NEC have a special IR message for repeat last button,

s/repeat/repeating/?

> + *		in case user is holding a button down; the scancode is
> + *		not repeated.
> + *
> + *		*ctx* pointer to bpf_rawir_event.

Please use a complete sentence here as well, if you do not mind.

> + *
> + *     Return
> + *		Always return 0 (for now)
>   */
Thanks,
Quentin
