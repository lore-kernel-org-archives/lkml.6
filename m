Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523261417; cv=none;
        d=google.com; s=arc-20160816;
        b=ienecGM8HACyHdOBxJZGTnlmLXT+hCznwg3HIVmTs7bP2s4SGkCZf/wrlzw81J+FEI
         w7OAOdc98ydHckciasTByS3S9K2H74NusMN0Z2n+775aWsiUeRf0P/CJCqK/uExfPCAg
         OuUNbSb+e2GbWqzfgkPfMnKafFh4Ub5OFY6KmYheOWY8iEcsFOze4C7r7/q3IDxC4PzD
         WQH13NvOyv0NFlV7/nlWoC30gqFmBQ4YtKbf6zcFHwIyFsc5jcg1eIzCFcoJxAitNFlH
         YBoRO/5hv7r/PXg07C3QxOhJunOKUpM+Aiiy9PqdmWzVGcKlx4egkAK7bxUN6PMNGIPj
         mMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=1HYOF1Fm3VD+7AX5NRsZHnk0HAgwtGcU8YRQZbCTMsw=;
        b=xadY/c73aYOpGyYB5J38U4r7XdC7ZymljZUzO4S5K/bdE7uHzeQWCx7zfT5tZXAjbG
         lR8kg1cZK56eCO08rfI0hBjXs5zNphULvARa3EknQGAhn3FlfSL11kVHbE4jmGUIVMxA
         AjR1Xsq2KHJMXMvf83FvI8bjD9UIv5zzA7LjguI7BNEJkhE38HNl1FyfOJAWytfY0V7a
         fXcB8X3fZqvLS/AtSr35bxJDzn0D/WBrpyrRy7mE7dTpVnO11o2QJ6zSN1nTbBoTMz4X
         wPc8hvYMNQhxdw/cdV5W0FopDChZp9gOnqCh8kGazcEBNefxkpA49Pj0Fp9C0ojYXiwy
         JFaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gEJPuC+W;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=gEJPuC+W;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+Ylyb+5KKCpDxQTcKDKQ/GBxwvi42NcLRVi8fyuxkuF7N0tjhZ7Kw5FjbdNdKyjFAeDc67e6Gs6GwC1KwIryA=
MIME-Version: 1.0
In-Reply-To: <20180408174014.21908-6-hdegoede@redhat.com>
References: <20180408174014.21908-1-hdegoede@redhat.com> <20180408174014.21908-6-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 9 Apr 2018 11:10:16 +0300
Message-ID: <CAHp75VdM2Z+GeHE6154h7jJ5q2rWCEbVqVZRvo49fvZuaQcGjQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] platform/x86: touchscreen_dmi: Add info for the
 Chuwi Vi8 Plus tablet
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Platform Driver <platform-driver-x86@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Jones <pjones@redhat.com>,
	Dave Olsthoorn <dave@bewaar.me>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>, David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, mfuzzey@parkeon.com,
	Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	Bjorn Andersson <bjorn.andersson@linaro.org>, Torsten Duwe <duwe@suse.de>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199794097798684?=
X-GMAIL-MSGID: =?utf-8?q?1597255364067106552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 8, 2018 at 8:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add touchscreen info for the Chuwi Vi8 Plus tablet. This tablet uses a
> Chipone ICN8505 touchscreen controller, with the firmware used by the
> touchscreen embedded in the EFI firmware.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 6488cd50ba79..5fdb6fe878f4 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -301,6 +301,22 @@ static const struct ts_dmi_data teclast_x3_plus_data = {
>         .properties     = teclast_x3_plus_props,
>  };
>
> +static const struct property_entry efi_embedded_fw_props[] = {
> +       PROPERTY_ENTRY_BOOL("efi-embedded-firmware"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data chuwi_vi8_plus_data = {
> +       .embedded_fw = {
> +               .name   = "chipone/icn8505-HAMP0002.fw",
> +               .prefix = { 0xb0, 0x07, 0x00, 0x00, 0xe4, 0x07, 0x00, 0x00 },
> +               .length = 35012,
> +               .crc    = 0x74dfd3fc,
> +       },
> +       .acpi_name      = "CHPN0001:00",
> +       .properties     = efi_embedded_fw_props,
> +};
> +
>  const struct dmi_system_id touchscreen_dmi_table[] = {
>         {
>                 /* CUBE iwork8 Air */
> @@ -487,6 +503,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
>                 },
>         },
> +       {
> +               /* Chuwi Vi8 Plus (CWI506) */
> +               .driver_data = (void *)&chuwi_vi8_plus_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Hampoo"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
> +               },
> +       },
>         { },
>  };
>
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko
