Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965384AbeE3Jmc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:42:32 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:57926 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965077AbeE3Jm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:42:28 -0400
X-AuditID: 0a3aad17-513ff70000000e32-6f-5b0e7204f7a0
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH v5] Input: add bu21029 touch driver
Thread-Topic: [PATCH v5] Input: add bu21029 touch driver
Thread-Index: AdP3+di3TTtD19e6S+yQZPEYU7QIAg==
Date: Wed, 30 May 2018 09:42:26 +0000
Message-ID: <a2306fd2b9d943379967ca9f0ab58063@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.191.65]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA21Tf0wTZxjm613LWbl6FEvfdcOQZmSJCFZh8aJCXPYj9Q83FpMlQjJ2wAnN
        aAt3wMAsC3MTqBLnUAYW5IcZ3fihQLM5mFRYbSbgYqfAgASYGThBS9wGzv1Q2B1XbP/YP5fn
        e97neZ/3ey8fgam/InSEyVLAchYmV69Q4srdF6Li5JwqzTA7guiFU1cR3ei5Iaevnp9HdM/U
        zxg9+cefcnrk23oF3TJ+U0Yfc3lC9xHGjoYOZGywD+LGXvt0qNHZZlMYl5xbUuSpyr1ZbK6p
        iOW2J7+jzHl0o0aR9zdefKtLW4rK8eNoAwFUIoyvDiARq6laGfxeu/E4Ugq4D8Fq46RCOiwi
        WOq4JZMOAwiW52xy0aKgdkO543qoiDdTxfDE4ZGLIowqxcDxfZ1MLERQu2DQ1+wX0eDwdssk
        HA/3v/kNEzFOxcBPDWNrc5DUHqidrljDiIqCri7vmgajtOD89ZFcmpuCz/skHigNLMyu+Plo
        +Lpt0q+Ph4nqMwoJx4Kj+T4m9Q+HobNz+CmksQe1tQdZ7EEWe5ClCeFtSMObDEXmnQY6IZ7L
        YPkjhh3xmVazE0l/UNuDlrsZN6IIpA8jW/NVaWo5U8SXmN3oRUKm15CYSaBUGdaskhyGz0nn
        CnNZXq8jUUhIiDriKc0XZphNPG+yWtwICEy/mSx0haWpySym5AjLWSWbGz1L4HotWZn1fqqa
        ymYK2HdZNo/l1qt7CEIP5Bd5QmA4x2azxYdNuQXrZX2UlBkZXAmOlREb3CiBCBOyh8UWJJ/H
        mHlTtt/+jGRXr7MB6zB6mfCVVVZiatxitbA6LXlCXAMlKnMKLU8n0D1HGu8Il9IEFQJd7qEZ
        JOwwghwVw8OEhxLIBrInov6QOtxPBkw72wQPNYxB/+QIgs6VRQHVVang5EyzCv45W70Jps7Z
        wmHiy0ENVDR5tsHyw2txMO67aRAkd2i4NOpKAk/n9Ctw+fbkq9A/VL8fLpY5D0DPZ98dAJun
        +Q2obq07CPNNrrdgytdyCCpWPnob+hvd6bDQ0ZgF8/+eM8Ppu2U8/GW/8gH0fXLtQwSjl8uP
        Iqjytgnfhfalj4WnVTZ2DN0TtisTtjv36UZxuwVMwf9s188GrqgrRUVJ3nBb9CKMqGruHk0u
        bx9/wVGTGeltvRB5MDphb4st//WTnLVqtcvIvpaoe7A9sWWX8xKd93xmzIMTWx++19yeMm/t
        m72SdHqfbc71Y3rMdW7osCW2eyX2sbK7PdmdNOB78+LjxW1PKrBNZ+Juv5TSmdhbn//D/oHU
        iV+2jM30nrfqcT6H2bEV43jmP0qlrEzHBAAA
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4U9h5JW003840

Hi,

> [PATCH v5] Input: add bu21029 touch driver
> 
> Add Rohm BU21029 resistive touch panel controller support with I2C
> interface.

Is the patch ready to be pushed upstream? Is there anything I still need to do?

Regards,
Mark

Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1) 
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY | www.boschsecurity.com 

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118
Aufsichtsratsvorsitzender: Stefan Hartung; Geschäftsführung: Gert van Iperen, Andreas Bartz, Thomas Quante, Bernhard Schuster
