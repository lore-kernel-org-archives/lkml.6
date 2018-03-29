Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522306535; cv=none;
        d=google.com; s=arc-20160816;
        b=mwA55IkfkzeywpwNnfXAi2qul6TcSrG9t7Bw1K6tq+kWUPr2iavpMXBxIsMR1qF0KB
         zTLYV9MiZhSgZ9Hz7buMK9B6TdeSS4MjXX2VqjQcsfkANUxoQyO+kUUNjyJTv3BZ+K8C
         lnPCPd3F5+P7ufV5hoVMJi1Twnfx8gct8ONY2OmApTYbqRD8h9vazNIdb8DGG2oIH3dj
         ChLYIpCxRDOvcnu0AfGJIz34EP43T3ZucMLP/W2mqJ67UoUuEkOo4Waa0vyOm5d+xXl1
         BLdPh8Y0WsOq81otKPjZbcBzWkUhPME8fgrOpcFFHzkzYTcUj8hQO6yoGmkaUw8eodKn
         axzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=tMJyirdL2SA5VjTzXIzKs6E49GxDLd5oceAy9JupsHk=;
        b=D3RCWlXOMwgXphRvjIgPzdsP81zCzxtv3kYyP4omUke8ceVaBQTz4KarIykmAjyxU6
         4ZJb+E8DkLDqJ56cPwvaWFUxXfO0N83e0Csg2i1TUCeM9y4cZowHikkxXWIHW06RE6b6
         IpKYdMaOCKTGAnt+khObvh6do02cJZeXI6JduVXhd/cxWtqTLNn8SD5Ic5arEnU4VS4a
         htiyU2wCY09FTYBsbHLxg1KZM67jZp2Ec39n9+KW/zRWEejlusSvuh65jMMU/N+pbo79
         NjC//mMObthBuX+Rjd9z1+vxd8phwvTFUr3JGzexREDl+vUCawJQs3QRQOyjq51xnSrQ
         C9Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lgZFk20i;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lgZFk20i;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AIpwx4+5TjFFza3Z5fbkA4Lb/OHE7owjATzY1G50Tio+PAT/5qf5/j87LKxa+eCOvehbIcu4Jajmo29P23TNbfdwR4g=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180328203659.18692-10-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com> <20180328203659.18692-1-shea@shealevy.com>
 <20180328203659.18692-10-shea@shealevy.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Mar 2018 08:55:34 +0200
X-Google-Sender-Auth: A5pTkIv7beZLg9Lf4HeiEHf5qGU
Message-ID: <CAMuHMdVs0U616sKVEsj5BqQUPv8xjoSLtAvpoYQwMDJOzSNq2Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/16] m68k: Use generic free_initrd_mem.
To: Shea Levy <shea@shealevy.com>
Cc: linux-riscv@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596215229649409530?=
X-GMAIL-MSGID: =?utf-8?q?1596254097217117788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:36 PM, Shea Levy <shea@shealevy.com> wrote:
> Signed-off-by: Shea Levy <shea@shealevy.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
