Return-Path: <stefan.wahren@i2se.com>
X-Google-Smtp-Source: AG47ELtJPv5B9APzmnvT43AEBQ+wp9ndEYWT8OfCT05LyzAKW2QZBr3DrTQ6O7YylU/EO0om3amq
ARC-Seal: i=1; a=rsa-sha256; t=1520424635; cv=none;
        d=google.com; s=arc-20160816;
        b=D+ciyKxG6B9S5R69MviJMEt4UGUsBoIhy9G+wLW/HBHppTsQ/bOrXehCliRUfnXjwF
         3OQtw9WsUY+FZjCFWuSns2LK1IdKvP6IvgQj0iRwmCVt7AlY9oT0xzlimtCjSDS1PESM
         F2GXSkUN5r8b7L+u5+Y3p1VQt0U0vtF2fu1zLo3gkRgTW++xPNO4qgvkhICPEn1wvLwA
         1LLt+UjzSWaCx0OBDS6KIK1n61VMELj2+RqlttL2cpVNeuLA6W2QDlFCQXzW5swFZZGm
         vzD/hLI9PPXoUaMV7SKwcUDhbLSw4grNQvAqtEROM35dZ6zHjr5VhnKCKSg/EIWpbZap
         B1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=importance:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date
         :arc-authentication-results;
        bh=EQTtTl2fx6KAGawhxJwPVR9ErwkbO5CYLsnu+O7ClJA=;
        b=rH+D9GmeU03xA8kzwAeU6L3SwR+7WTQ81BlQLAaDszysqHLuN51TtFoFnYIFnhE3r1
         J4toLp5Qhjd5FncSYEXBrwUTMvUdq3qpFVcwoqlcV6NOCj54KKw9mrdrd1iD3CvAnygQ
         +7ojJ0eZBWfvP1nmxeExLScoCHMfG9XZVQ6Bj3CyMxB3h/64r8IV0qNE94LqKjOk8yCt
         3t5IOHWqlC1KPdJvBc5f+Yb5zfmvna0eC9KRBnS6XyqT+tibPbTsexV53hilgJzKWSFQ
         dJlLwhn56ASU70/Ker/LjMOzwAQxTuMXlZMCzmjNJ8pLbvynXwZajIuOey4hkjuGODNN
         FLAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.126.131 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Date: Wed, 7 Mar 2018 13:10:30 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Eric Anholt <eric@anholt.net>, Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>, devicetree@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Message-ID: <1332781939.275857.1520424630939@email.1und1.de>
In-Reply-To: <638bd870-bb17-a0e1-d2aa-30a364b53279@raspberrypi.org>
References: <20180305202806.21219-1-eric@anholt.net>
 <20180305202806.21219-3-eric@anholt.net>
 <a8f369f5-691c-c05f-4c7c-2eadcf4c48c8@i2se.com> <87muzl9ger.fsf@anholt.net>
 <638bd870-bb17-a0e1-d2aa-30a364b53279@raspberrypi.org>
Subject: Re: [PATCH 2/5] staging: vc04_services: Remove cache-line-size
 property.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:vusHja4DW60gCRotraaJUea26LNvfq/yxPduER/yzyzQFbzLXVw
 hAda2+Vcsfc+xCT7dyw7w/a5/Or5v8fPQcUOK+BFNgSKZkJ+sCldOkuxVCJwF+hFzwwZrsc
 DcKrDNyqQ4U3XanRwokRwuLz9ckpAfGtre+B7B4WZ3m3X3BePdS1c18bL+UH+V8s5bps3TS
 b1tdSilNK7vNn15MqSOYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zJUSCRdsQjk=:5Q+EIuOlblC18h13wPlHNU
 8mA8AOTg5aeg118fqAJWXtWXLx+7ulSA9J7Ca8360zCiuaLFAj7id3QILF0UDDkjELTiutge2
 gud4AM5jJEvmy5cvYuY/VdOigKQyYSqhQIlHpQkB/zinVi7q7PE1+FQvPeG6TwTyIyFi8WBV3
 J3FI+3vrhiwq0gb5XzGKbbrmHoOXW2uNNHmydDpkFV00P6Xq+fZUWGjfyhk0xRF0jT5keeFJk
 blvjhWfphgbmPcYZqm9o2wIHI9SE0DhxlWipteh/dFOLQ4AdjINwFCKPg0GH4nbiGEUQAcVrl
 ON4DNiLZ4GFkwdCFbOOHCGwjJ/rg0LrUcx5nf4/F2YJs5J58srexWUpBCviSdBroj67Sj65Wp
 ScOTQVkDHhzfU7n2C2uKfnNonDet23LsO58AUA7bTZ+kWkKBhRtU0gaASrY7zqPtqlfAq7MVZ
 qtmCpiTCM0obU1iXi8M1pP/iq6FFUVwD9mq7/WUIAEEtHozpvogaGGfqWbXeHFSYR0LWCVdPA
 haDSyeM37os0r2BNgjDwQyt15PfqYw3eGrLG7tphzyibhi3mLnDiOkLwSkPAWdV+9866S8yjO
 PE8Div8n1U7KWoG6jonuKEfHhAnby7KxyU84zJdmSoCskdjTtX0nLKDIjtujFUiaGx2VNANhA
 RzGBjuyPR2x0YAQEY6gc2fzFDMVhezdpcMwFdYX6n05or4RWgXJKd4R/USgwym22s56Eg0een
 M97OpxpInyENTZiRIqHLSwhh3xkgiTqEivFzIidz7XT823A/iawE/dG875M=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130896333791997?=
X-GMAIL-MSGID: =?utf-8?q?1594280782313479027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Phil,

> Phil Elwell <phil@raspberrypi.org> hat am 7. M=C3=A4rz 2018 um 09:02 gesc=
hrieben:
>=20
>=20
> Hi Eric,
>=20
> On 06/03/2018 19:02, Eric Anholt wrote:
> > Stefan Wahren <stefan.wahren@i2se.com> writes:
> >=20
> >> Hi Eric,
> >>
> >>
> >> Am 05.03.2018 um 21:28 schrieb Eric Anholt:
> >>> This was just a way for the DT-passed value to get out of sync with
> >>> what Linux has configured the ARM for.
> >>>
> >>> Signed-off-by: Eric Anholt <eric@anholt.net>
> >>> ---
> >>>    .../interface/vchiq_arm/vchiq_2835_arm.c           | 25 +++++++---=
------------
> >>>    .../interface/vchiq_arm/vchiq_pagelist.h           |  1 -
> >>>    2 files changed, 8 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_=
2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_a=
rm.c
> >>> index b59ef14890aa..e0e01c812036 100644
> >>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_ar=
m.c
> >>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_ar=
m.c
> >>> @@ -77,7 +77,6 @@ struct vchiq_pagelist_info {
> >>>    };
> >>>   =20
> >>>    static void __iomem *g_regs;
> >>> -static unsigned int g_cache_line_size =3D sizeof(CACHE_LINE_SIZE);
> >>>    static unsigned int g_fragments_size;
> >>>    static char *g_fragments_base;
> >>>    static char *g_free_fragments;
> >>> @@ -117,15 +116,7 @@ int vchiq_platform_init(struct platform_device *=
pdev, VCHIQ_STATE_T *state)
> >>>    =09if (err < 0)
> >>>    =09=09return err;
> >>>   =20
> >>> -=09err =3D of_property_read_u32(dev->of_node, "cache-line-size",
> >>> -=09=09=09=09   &g_cache_line_size);
> >>> -
> >>> -=09if (err) {
> >>> -=09=09dev_err(dev, "Missing cache-line-size property\n");
> >>> -=09=09return -ENODEV;
> >>> -=09}
> >>> -
> >>> -=09g_fragments_size =3D 2 * g_cache_line_size;
> >>> +=09g_fragments_size =3D 2 * cache_line_size();
> >>>   =20
> >>>    =09/* Allocate space for the channels in coherent memory */
> >>>    =09slot_mem_size =3D PAGE_ALIGN(TOTAL_SLOTS * VCHIQ_SLOT_SIZE);
> >>> @@ -548,9 +539,9 @@ create_pagelist(char __user *buf, size_t count, u=
nsigned short type)
> >>>   =20
> >>>    =09/* Partial cache lines (fragments) require special measures */
> >>>    =09if ((type =3D=3D PAGELIST_READ) &&
> >>> -=09=09((pagelist->offset & (g_cache_line_size - 1)) ||
> >>> +=09=09((pagelist->offset & (cache_line_size() - 1)) ||
> >>>    =09=09((pagelist->offset + pagelist->length) &
> >>> -=09=09(g_cache_line_size - 1)))) {
> >>> +=09=09 (cache_line_size() - 1)))) {
> >>>    =09=09char *fragments;
> >>>   =20
> >>>    =09=09if (down_interruptible(&g_free_fragments_sema) !=3D 0) {
> >>> @@ -598,10 +589,10 @@ free_pagelist(struct vchiq_pagelist_info *pagel=
istinfo,
> >>>    =09=09=09g_fragments_size;
> >>>    =09=09int head_bytes, tail_bytes;
> >>>   =20
> >>> -=09=09head_bytes =3D (g_cache_line_size - pagelist->offset) &
> >>> -=09=09=09(g_cache_line_size - 1);
> >>> +=09=09head_bytes =3D (cache_line_size() - pagelist->offset) &
> >>> +=09=09=09(cache_line_size() - 1);
> >>>    =09=09tail_bytes =3D (pagelist->offset + actual) &
> >>> -=09=09=09(g_cache_line_size - 1);
> >>> +=09=09=09(cache_line_size() - 1);
> >>
> >> should it be so easy? Back in 2016 we said that cache_line_size() won'=
t
> >> work. I always thought that we need the cache line size of L2 not of t=
he
> >> L1 one.
> >>
> >> Did you already test the behavior for these combinations?
> >> BCM2835 ARM32, expected cache line size =3D 32
> >> BCM2836 ARM32, expected cache line size =3D 64
> >> BCM2837 ARM32, expected cache line size =3D 64
> >> BCM2837 ARM64, expected cache line size =3D 64
> >=20
> > I didn't explicitly test, but was going by:
> >=20
> > config ARM_L1_CACHE_SHIFT_6
> > =09bool
> > =09default y if CPU_V7
> > =09help
> > =09  Setting ARM L1 cache line size to 64 Bytes.
> >=20
> > config ARM_L1_CACHE_SHIFT_7
> > =09bool
> > =09help
> > =09  Setting ARM L1 cache line size to 128 Bytes.
> >=20
> > config ARM_L1_CACHE_SHIFT
> > =09int
> > =09default 7 if ARM_L1_CACHE_SHIFT_7
> > =09default 6 if ARM_L1_CACHE_SHIFT_6
> > =09default 5
> >=20
> > and only L1_CACHE_SHIFT_7 gets selected by UNIPHIER and neither one is
> > accessible by menus.
> >=20
> > I think you're technically correct that it's the size of L2 that matter=
s
> > (or, specifically, the hardcoded value that the firmware is using on it=
s
> > side for the fragments list handling.  It overrides a cache-line-size D=
T
> > property with that number if present).  However, I think L1=3D=3DL2 cac=
he
> > line size this should be a safe assumption for us.
> >=20
> > Phil, any opinion?
>=20
> It is the L2 cache line size that matters, but as long as you end up with
> the numbers Stefan mentioned - 32 on BCM2835, 64 on BCM2836 and BCM2837 -
> I'm not too bothered how you get there.

i think a kernel with bcm2835_defconfig on RPi 2 could be such a corncase.

Am i right that the firmware doesn't rely on the existence of "cache-line-s=
ize"?

Btw it would be nice to get fixed the corruption on ARM64 [1].

Stefan

[1] - https://github.com/lategoodbye/rpi-zero/issues/23

>=20
> Phil
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
