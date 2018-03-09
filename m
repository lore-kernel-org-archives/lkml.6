Return-Path: <stefan.wahren@i2se.com>
X-Google-Smtp-Source: AG47ELugcbFrMtwA+pFuCZNoqkTzjfRzNO0v1NBCirWtWLcoqHiyCVlULmyKF1qvuxuAFDb9vczH
ARC-Seal: i=1; a=rsa-sha256; t=1520627496; cv=none;
        d=google.com; s=arc-20160816;
        b=vu1yOJVqbpIQ4LYPCXkrGgrkzUrwHVGeGc7lxYjihb/UghIq5fOVFKkkxZW3mG+FIs
         R6w0KeWArDsltQRwNZzgkgUe1ETVvRUZEyK7aWQS9UcHOboi1OyZ/PV0EfnbBp6d2lmc
         yPIQ9ygyIwDuIody7RqzwrbhXJsHalaa6nV2hFaj9ZuhE1ptBxPDnv+e1+yLIYSJ/pox
         QlM8mj9dv7WvJF4Qxhdz9Zudl7OlCbveMWswZaj+dlY+2ghINHUqtIWiOprEzpvgIdVt
         Pez+wSXBkehsGAWALGH6ZpYNdOoqbjLmj1fAWTlw5O/eEOt1TSsKmmq1rQsJj8vve6wo
         ObeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=importance:content-transfer-encoding:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date
         :arc-authentication-results;
        bh=me3PXnHp8XbclKECI58CiAN8l58uCJ3VUxuEvPvq2Xg=;
        b=j5y6zt+z0zQ5+MQr5RPsQ7sgqHGBiM8resKPcXzYtA+28JzY3PbGLPu6Jlbb5bnZ7C
         /obJ/S0H56pX03uoJMBZqepT5e1by4mhp/7FukMEG9MaalpPnVWxQ1dg9dlEHRwlGthv
         T6cYQZWKBUGnhoYBK/zOjW2cEO2iNbywB8t+sQ6qpdfKmodzBosjyf9ev8N/c/a3ktTb
         Bs1xYHoYkh1xiX8J6/nnqu3f1fkswicFi8+CnCAVvJoVJlr85VCmIKeeo4Bi3G6bYRsl
         +BCYQ9blyMkYCVCIW83XF8JDLRmtoTSI3EQxxQMST6KZs/Qtn9hzO52FlVS60tWtg5J4
         TYKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.227.17.10 is neither permitted nor denied by best guess record for domain of stefan.wahren@i2se.com) smtp.mailfrom=stefan.wahren@i2se.com
Date: Fri, 9 Mar 2018 21:31:30 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Eric Anholt <eric@anholt.net>, Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>, devicetree@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Message-ID: <1683748924.258615.1520627491004@email.1und1.de>
In-Reply-To: <20180309184417.23368-3-eric@anholt.net>
References: <20180309184417.23368-1-eric@anholt.net>
 <20180309184417.23368-3-eric@anholt.net>
Subject: Re: [PATCH v3 3/6] dt-bindings: soc: Add a binding for the Broadcom
 VCHIQ services. (v3)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:hKrb2U6QdHRk7aA/2M7V8mwsdLG6NIL4JazKR/dQfRQ+NEEg7mU
 jpME3uOiOSJjW9NEGgBtoJ9RSO65GGDaHdyr6FUa5g+w/b1mM9RU8Lv/YLeHrD6awtIz9Cu
 2SrUYSprmU3D0LwP7wB28/YCreL/4pbIFfOte1aoMo+h3LW2FGukSfyYfaljMQVwTSbpvAg
 CQm0QE+lfN1NAQMe+9KjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vp7nXWpXL5U=:tJKYNYonK0lod0ipp2t2df
 jdps8+HnQ3Uoqm/fK0xxa2WP9rZW0c6gvuSUuQM6jJQePtHgoAsy2HN1VR8CkKdzca28a/O6m
 8MGXCJ7WzbWKs3Mhgbmsv7ZvfVhb4AntO328NNr0+i66rEolJKkt69Z1jDqQ14xRbZOPfDchE
 V26HIxJ6NqEoo/UU3oDHmlQA4CIpX5BZY2yc4YatzZt3QQIegjrW9n1QM56xn/zRoUJMVEYIS
 HxHOeBxPKqMEq2NfiMtbsxS3tHB2PrlLQ9/ffFVpARnpeaXIApfdgzEddF/gmF9STgQh4av63
 ERX+ABNMfG6MF33agC2TntnJEaMBtibGKzAXvz6eq594cjed9s3LFLrypqkp9hQQdIEOodeCL
 h/Q7KNrLp/edDbr6VOOpAwwWmsZA2y0GioDVwot2v2eWY06yWotfSFd0bB7r56g1SbbVVDFt9
 QvVBGfLxyHlF6yY30aFRz+Q2JGs+dTLAoTnYAbEMuaLj5d3g4palqjTgA49ijx7qBGDG4Hke9
 U/o+mcVoLhp92FhYtzPy8Ad5OV8AihHjOOwokuR1Bnw5hxt2svSyk+/R7xqa8/fEZYeGf3gcg
 DOGFVXKqvgPwmg2cqUBGCQryeGJ6o/T5HfgWubk/p7s/c319zmC9OvHHqYF5kv3Ui4JZqPzjo
 dQZcaK5il4ND2rusvhOYMj77zL0VP9/JSJvMpQb3akc+XvUhkj1LZLk4rayCQwv1c8Uk5Zg+g
 SYZ0H3O+bD4OpWvmCDBV1eCGCNsJrjmnnXPKFluwG/asX8QbXFazs7EL0Fo=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594486750832006220?=
X-GMAIL-MSGID: =?utf-8?q?1594493497948676815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 9. M=C3=A4rz 2018 um 19:44 geschrieb=
en:
>=20
>=20
> The VCHIQ communication channel can be provided by BCM283x and Capri
> SoCs, to communicate with the VPU-side OS services.
>=20
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>=20
> v2: VCHI->VCHIQ, dropped firmware property, added cache-line-size
> v3: Dropped cache-line-size, s/vchi@/mailbox@/
>=20
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt   | 16 ++++++++++=
++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm283=
5-vchiq.txt
>=20
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq=
.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> new file mode 100644
> index 000000000000..8dd7b3a7de65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt
> @@ -0,0 +1,16 @@
> +Broadcom VCHIQ firmware services
> +
> +Required properties:
> +
> +- compatible:=09Should be "brcm,bcm2835-vchiq"
> +- reg:=09=09Physical base address and length of the doorbell register pa=
ir
> +- interrupts:=09The interrupt number
> +=09=09  See bindings/interrupt-controller/brcm,bcm2835-armctrl-ic.txt
> +
> +Example:
> +
> +mailbox@7e00b840 {

just a question: do you think this is future-proof to claim the doorbell fo=
r VCHIQ?

Stefan

> +=09compatible =3D "brcm,bcm2835-vchiq";
> +=09reg =3D <0x7e00b840 0xf>;
> +=09interrupts =3D <0 2>;
> +};
> --=20
> 2.16.2
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
