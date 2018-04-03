Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbeDCM6R (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:58:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:27000 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeDCM6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:58:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180403125813epoutp02019cdde727e4578e70941efa763a3a75~h7mtgsn3H0859008590epoutp02t
X-AuditID: b6c32a49-71dff70000000fee-75-5ac37a64a92c
Message-ID: <1166142499.594566.1522760284362.JavaMail.jboss@ep1ml501>
Mime-Version: 1.0
Subject: RE: [PATCH v2] arm/stacktrace: stop unwinding after an invalid
 address.
Reply-To: v.narang@samsung.com
From: Vaneet Narang <v.narang@samsung.com>
To: Maninder Singh <maninder1.s@samsung.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "dustinb@codeaurora.org" <dustinb@codeaurora.org>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1521630645-46715-1-git-send-email-maninder1.s@samsung.com>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Date: Tue, 03 Apr 2018 18:28:04 +0530
X-CMS-MailID: 20180403125804epcms5p382d3d7ce979f0923eeb71f3414175eed
Content-Type: multipart/mixed;
        boundary="----=_Part_594565_288609395.1522760284362"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180403125804epcms5p382d3d7ce979f0923eeb71f3414175eed
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmum5K1eEogz3bLS0u7k61eN69mM1i
        0+NrrBaXd81hszg0dS+jxeH5bSwW995sZXJg97h87SKzx+W+XiaPzUvqPfq2rGL0+LxJLoA1
        KtUmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gIJYWy
        xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUrShoZGeoYG5npGRkZ6JaayVkSlQSUJqxo9vf9kL
        NktVbGprZ2pgPCHZxcjJISFgIjFhwkvWLkYuDiGB3YwSv5/uYuti5ODgFXCVuL3GB8IUlPi7
        QxjEFBYIknjwkQ2kU0hATuL4jd2MILawgI7EiXlrGEFK2AS0JD62hIMMFBGYxCjxbv1nZhCH
        WeAJo8Sh1UfZINbySsxof8oCYUtLbF++FWwQp4CHxN57rxgh4qISfxpgakQl3h+bDxUXkWi9
        d5YZwhaUePBzN1RcRuL7136wVyQEuoE2T97NAuFMYZRoeAPTbS5x/uR8sG4WAVWJp09XsEPE
        XSTm3LwMFmcWCJW4ub8Pql5WYuqpdUwQtq3ElR3djBA1fBK9v58wwXyzYx6MrSRx7uBOqC8l
        JJ50zoS61EPixuZeqJmOEuduXWKdwKg4CxG+s5BshrC1JZYtfM0MUsIsoCmxfpc+RFhNYkr/
        FzYI20yioX0qC4StKDGl+yH7Akb2VYySqQXFuempxaYFhnmp5XrFibnFpXnpesn5uZsYwalX
        y3MH46xzPocYBTgYlXh4C1wPRQmxJpYVV+YeYlQBmvVow+oLjFIsefl5qUoivHOzDkcJ8aYk
        VlalFuXHF5XmpBYfYjQFht9EZinR5HxgvsgriTc0sTQwMTMzNzQwsDRREud1DHSJEhJITyxJ
        zU5NLUgtgulj4uCUamDU3PbWL3qNyodgrj+HHuwuP6fpr7fy4vHot0XxkzgaeVhXPr7Gw53w
        ddIt47Nrxe17q7/wz74Rl341oNvgctAdcb/+v+8vVd2cwCW97F6H9ud2qbtaFakfzni4zWA9
        vVnARtR+S9iMdgafosNP1tea3X0Skr54YvX/9tRL+428Ove0X1vFodSuxFKckWioxVxUnAgA
        /HruK98DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9
X-RootMTR: 20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9
References: <1521630645-46715-1-git-send-email-maninder1.s@samsung.com>
        <CGME20180321111139epcas5p4d5b75f4e1b572ae4e55aef737cd6d8e9@epcms5p3>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_594565_288609395.1522760284362
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

=C2=A0=0D=0AHi=20Russell,=0D=0A=0D=0A=0D=0A>__dabt_usr+0x44/0x60=0D=0A>0xb6=
748ea4=0D=0A>=5E=5E=5E=5E=5E=5E=5E=5E=0D=0A=0D=0A>---=20a/arch/arm/kernel/s=
tacktrace.c=0D=0A>+++=20b/arch/arm/kernel/stacktrace.c=0D=0A>=40=40=20-92,6=
=20+92,9=20=40=40=20static=20int=20save_trace(struct=20stackframe=20*frame,=
=20void=20*d)=0D=0A>=20=0D=0A>=20=09regs=20=3D=20(struct=20pt_regs=20*)fram=
e->sp;=0D=0A>=0D=0A>+=09if=20(=21__kernel_text_address(regs->ARM_pc))=0D=0A=
>+=09=09return=201;=0D=0A>+=0D=0A>=20=09trace->entries=5Btrace->nr_entries+=
+=5D=20=3D=20regs->ARM_pc;=0D=0A=20=0D=0A=C2=A0=0D=0AAny=20Inputs=20or=20Co=
mments=20on=20this=20patch=20to=20avoid=20storing=20user=20space=20entries=
=20=0D=0Aduring=20unwind.=0D=0A=C2=A0=0D=0ARegards,=0D=0AVaneet=20Narang
------=_Part_594565_288609395.1522760284362
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="rcptInfo.txt"
Content-Transfer-Encoding: base64

DQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIFN1YmplY3QgICAgOiBbUEFUQ0ggdjJdIGFybS9z
dGFja3RyYWNlOiBzdG9wIHVud2luZGluZyBhZnRlciBhbiBpbnZhbGlkIGFkZHJlc3MuDQogICAg
ICBGcm9tICAgICAgIDogTWFuaW5kZXIgU2luZ2ggRW5naW5lZXIvU1JJLURlbGhpLVBsYXRmb3Jt
IFMvVyAxIFRlYW0vU2Ftc3VuZ8KgRWxlY3Ryb25pY3PCoA0KICAgICAgU2VudCBEYXRlICA6IDIw
MTgtMDMtMjEgMTY6NDEgIEdNVCs1OjMwDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgICAgICAg
ICAgICAgIE5hbWUgICAgICAgICAgICAgICAgVHlwZSAgICAgICAgICBKb2IgVGl0bGUgICAgICAg
ICAgICAgICAgICAgICAgIERlcHQuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENvbXBh
bnkgICAgICAgICAgICAgICAgDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCiAgICAgIGxpbnV4QGFybWxp
bnV4Lm9yZy51ayAgICAgICAgICBUTw0KICAgICAgZHVzdGluYkBjb2RlYXVyb3JhLm9yZyAgICAg
ICAgIFRPDQogICAgICBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluLi4uICAgQ0MNCiAgICAgIGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgICBDQw0KICAgICAgQU1JVCBTQUhSQVdBVCAgICAg
ICAgICAgICAgICAgIENDICAgICAgICAgU3RhZmYgRW5naW5lZXIgICAgICAgICAgICAgU1JJLURl
bGhpLVBsYXRmb3JtIFMvVyAxIFRlYW0gICAgICAgICAgICAgU2Ftc3VuZ8KgRWxlY3Ryb25pY3MN
CiAgICAgIFBBTktBSiBNSVNIUkEgICAgICAgICAgICAgICAgICBDQyAgICAgICAgIFByaW5jaXBh
bCBQcm9mZXNzaW9uYWwgICAgIFNSSS1EZWxoaS1QbGF0Zm9ybSBTL1cgMSBUZWFtICAgICAgICAg
ICAgIFNhbXN1bmfCoEVsZWN0cm9uaWNzDQogICAgICBNYW5pbmRlciBTaW5naCAgICAgICAgICAg
ICAgICAgQ0MgICAgICAgICBFbmdpbmVlciAgICAgICAgICAgICAgICAgICBTUkktRGVsaGktUGxh
dGZvcm0gUy9XIDEgVGVhbSAgICAgICAgICAgICBTYW1zdW5nwqBFbGVjdHJvbmljc8KgDQogICAg
ICBWYW5lZXQgTmFyYW5nICAgICAgICAgICAgICAgICAgQ0MgICAgICAgICBTdGFmZiBFbmdpbmVl
ciAgICAgICAgICAgICBTUkktRGVsaGktUGxhdGZvcm0gUy9XIDEgVGVhbSAgICAgICAgICAgICBT
YW1zdW5nIEVsZWN0cm9uaWNzDQogICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCg==

------=_Part_594565_288609395.1522760284362--
