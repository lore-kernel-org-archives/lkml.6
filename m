Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B982C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C4A2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C4A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=real-time-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeGZJ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:26:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58622 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbeGZJ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:26:58 -0400
Received: from pc00012.rts.com ([46.237.192.139]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LbO0s-1gOqwD23B4-00kxkv; Thu, 26 Jul 2018 10:10:43 +0200
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <f1fb3e5e-f18a-9f89-84c5-1dc73e08ceef@real-time-systems.com>
 <20180725212122.f2m3cfiqb4az3cb7@black.fi.intel.com>
From:   Dmitry Malkin <d.malkin@real-time-systems.com>
Organization: Real-Time Systems GmbH
Message-ID: <a3e428be-0875-3b64-7680-252cd61b52c9@real-time-systems.com>
Date:   Thu, 26 Jul 2018 10:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180725212122.f2m3cfiqb4az3cb7@black.fi.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020609080108050805000505"
X-Provags-ID: V03:K1:ZtzPUj8pT2NdlyrDQ7t8nBShvk4EwZLyDgYTDLVI7ggvcTSIFZ0
 5O1YxcaFaWUDO/5HcU9rPP31+7STYAjpWWnvlYa7iuxaKo6d1eHIJaQNOkbhXLA6MADQjqn
 /C9eGoMX9MQSJGV41lOyFrBuM3xiqU+DxpepxMjwWv4QJlr6bqtq+nMdL43+CXQC4jQTTom
 xf3tGRCnEvjhHa/pVIEBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P3ygflcy/PU=:B166mSLvFF3on6JjuN/vNH
 IvE910wfWdwSW/Xp7QvF/CY6ERJXmsOZhPRZW9uMJrpRWCy2L7j6/5GX8hDp18i/1AzG4CTLv
 mR9/LSAodagbD0JyxjOJy8g9MYKsKyXAD+kfuFfxjbFoEogOLUiVh3l5XmAlpuEvucWjiafmR
 lljPl4Mf3WYOTHdjBMFcl7Hnll0/Tn8g7gl/PyaUybBPSSPlMBWfJ/jyyP/6Wyodd5HjqkORY
 iCDoj0jHPj9w5UeBmFqQYB5Q6zgmnHWWg6M0Sc3nn3Gt+tEwYkJJrvdYIq92pTZxEBT1pvCEE
 8GVPDeiwk8bh3qF2qGsEzEZQOnyCHSylYxo4FvTGQnhTrko9QVjnI4ILGFrFWqOpxvb+5kj9n
 zO4R5sGSVNYn6B0l48PwutJcNhpUM0v7Bofc/989rib6lqXhcgA/Ct6YIwiDQK/OJ3ObP5M23
 y6BkhWmO6ujnHK0tQFMyObsy8KX5f941iRbLp/dyjt8KdHbYjI9eSccCMAonclv1bJIIL99Bn
 t0lWagyg5SkMVAsny9Sjb89/0BUBbTEQeoe0MgeTTtaQCvEa8ABs8+f/i+aVCRiHOiQ2mmmn2
 f9rDXaTyAwMKCarNRoVIQPKeKIhVCA3FMevkzSZhaGall/kcHl4ZpQS04ncFNxeLJed7sPVAA
 NrffdtTFOBRBNdr4J+cOaS+pMAk27G/tTg42F1fpCo86HE0BYb2KfyiErfYsN5CLrRZo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020609080108050805000505
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US



On 07/25/2018 11:21 PM, Kirill A. Shutemov wrote:
> On Wed, Jul 25, 2018 at 05:26:02PM +0000, Dmitry Malkin wrote:
>> there may be some other reasons which may cause undefined behavior (re=
boot
>> for example):
>>
>> in arch/x86/boot/compressed/pgtable_64.c in function paging_prepare():=

>>
>> 1. structure "paging_config" allocated on stack without setting defaul=
t
>> value for flag "l5_required":
>>>> struct paging_config paging_config =3D {};
>> l5_required is set only if CONFIG_X86_5LEVEL is defined
> Hm? C99 initializer zeros the structure.
https://elixir.bootlin.com/linux/latest/source/Makefile#L366
Here I only see std=3Dgnu89.
>
>> 2. reading from memory which may be reserved in case of EFI systems:
>>>>  =C2=A0=C2=A0 ebda_start =3D *(unsigned short *)0x40e << 4;
>>>>  =C2=A0=C2=A0 bios_start =3D *(unsigned short *)0x413 << 10;
>> Also, on EFI system without CSM it will results in all zeros. Which wi=
ll
>> place trampoline_start to 0x9d000. And it also may be reserved memory.=
 In
>> fact I have such system and it is causes instant reboot (when code sta=
rts
>> copying to "trampoline_start").
> Could you show dmesg from such system?
Sure, here it is (please note than not both pages are reserved but only=20
second one: 0x9e000-0x9ffff):

[=C2=A0=C2=A0=C2=A0 0.000000] Linux version 4.17.9-1.el7.elrepo.x86_64=20
(mockbuild@Build64R7) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-28)=20
(GCC)) #1 SMP Sun Jul 22 11:57:51 EDT 2018
[=C2=A0=C2=A0=C2=A0 0.000000] Command line:=20
BOOT_IMAGE=3D/boot/vmlinuz-4.17.9-1.el7.elrepo.x86_64=20
root=3DUUID=3D51cc5f87-2bb2-45b5-a0ee-691970f9cf06 ro crashkernel=3Dauto =
rhgb=20
quiet
[=C2=A0=C2=A0=C2=A0 0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x=
87 floating=20
point registers'
[=C2=A0=C2=A0=C2=A0 0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'S=
SE registers'
[=C2=A0=C2=A0=C2=A0 0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'A=
VX registers'
[=C2=A0=C2=A0=C2=A0 0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'M=
PX bounds=20
registers'
[=C2=A0=C2=A0=C2=A0 0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'M=
PX CSR'
[=C2=A0=C2=A0=C2=A0 0.000000] x86/fpu: xstate_offset[2]:=C2=A0 576, xstat=
e_sizes[2]: 256
[=C2=A0=C2=A0=C2=A0 0.000000] x86/fpu: xstate_offset[3]:=C2=A0 832, xstat=
e_sizes[3]: 64
[=C2=A0=C2=A0=C2=A0 0.000000] x86/fpu: xstate_offset[4]:=C2=A0 896, xstat=
e_sizes[4]: 64
[=C2=A0=C2=A0=C2=A0 0.000000] x86/fpu: Enabled xstate features 0x1f, cont=
ext size is=20
960 bytes, using 'compacted' format.
[=C2=A0=C2=A0=C2=A0 0.000000] e820: BIOS-provided physical RAM map:
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000=
0000057fff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x0000000000058000-0x000000=
0000058fff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000=
000009dfff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000=
000009ffff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000000e0000-0x000000=
00000e0fff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000=
00c4a14fff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000c4a15000-0x000000=
00c4a15fff]=20
ACPI NVS
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000c4a16000-0x000000=
00c4a3ffff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000c4a40000-0x000000=
00c91acfff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000c91ad000-0x000000=
00c9749fff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000c974a000-0x000000=
00c9776fff]=20
ACPI data
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000c9777000-0x000000=
00cba86fff]=20
ACPI NVS
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000cba87000-0x000000=
00cbefdfff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000cbefe000-0x000000=
00cbefefff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000cbf00000-0x000000=
00cbffffff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000f8000000-0x000000=
00fbffffff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000fe000000-0x000000=
00fe010fff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000fec00000-0x000000=
00fec00fff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000fee00000-0x000000=
00fee00fff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x00000000ff000000-0x000000=
00ffffffff]=20
reserved
[=C2=A0=C2=A0=C2=A0 0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000=
022f7fffff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] NX (Execute Disable) protection: active
[=C2=A0=C2=A0=C2=A0 0.000000] e820: update [mem 0xc42c9018-0xc4321057] us=
able =3D=3D> usable
[=C2=A0=C2=A0=C2=A0 0.000000] e820: update [mem 0xc42c9018-0xc4321057] us=
able =3D=3D> usable
[=C2=A0=C2=A0=C2=A0 0.000000] e820: update [mem 0xc42b9018-0xc42c8c57] us=
able =3D=3D> usable
[=C2=A0=C2=A0=C2=A0 0.000000] e820: update [mem 0xc42b9018-0xc42c8c57] us=
able =3D=3D> usable
[=C2=A0=C2=A0=C2=A0 0.000000] e820: update [mem 0xc42a8018-0xc42b8257] us=
able =3D=3D> usable
[=C2=A0=C2=A0=C2=A0 0.000000] e820: update [mem 0xc42a8018-0xc42b8257] us=
able =3D=3D> usable
[=C2=A0=C2=A0=C2=A0 0.000000] extended physical RAM map:
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x0000000000000000-0x0000000000057fff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x0000000000058000-0x0000000000058fff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x0000000000059000-0x000000000009dfff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x000000000009e000-0x000000000009ffff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000000e0000-0x00000000000e0fff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x0000000000100000-0x00000000c42a8017] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c42a8018-0x00000000c42b8257] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c42b8258-0x00000000c42b9017] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c42b9018-0x00000000c42c8c57] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c42c8c58-0x00000000c42c9017] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c42c9018-0x00000000c4321057] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c4321058-0x00000000c4a14fff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c4a15000-0x00000000c4a15fff] ACPI NVS
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c4a16000-0x00000000c4a3ffff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c4a40000-0x00000000c91acfff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c91ad000-0x00000000c9749fff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c974a000-0x00000000c9776fff] ACPI data
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000c9777000-0x00000000cba86fff] ACPI NVS
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000cba87000-0x00000000cbefdfff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000cbefe000-0x00000000cbefefff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000cbf00000-0x00000000cbffffff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000f8000000-0x00000000fbffffff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000fe000000-0x00000000fe010fff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000fec00000-0x00000000fec00fff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000fee00000-0x00000000fee00fff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x00000000ff000000-0x00000000ffffffff] reserved
[=C2=A0=C2=A0=C2=A0 0.000000] reserve setup_data: [mem=20
0x0000000100000000-0x000000022f7fffff] usable
[=C2=A0=C2=A0=C2=A0 0.000000] efi: EFI v2.40 by American Megatrends
[=C2=A0=C2=A0=C2=A0 0.000000] efi:=C2=A0 ESRT=3D0xcbd9de18=C2=A0 ACPI=3D0=
xc974f000=C2=A0 ACPI=20
2.0=3D0xc974f000=C2=A0 SMBIOS=3D0xcbd99000=C2=A0 SMBIOS 3.0=3D0xcbd98000
[=C2=A0=C2=A0=C2=A0 0.000000] SMBIOS 3.0.0 present.
[=C2=A0=C2=A0=C2=A0 0.000000] DMI: SIEMENS AG RackPC_547G_HG-B.2.0/D3445-=
S1, BIOS=20
V5.0.0.11 R1.11.0 for D3445-S1x=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
02/24/2016


>> 3. paging_prepare(void) returns "struct paging_config". Copy by value.=
 Is it
>> really specified by ABI or GCC itself that the second field (which is =
flag
>> "l5_required") will go to RDX register?
> https://github.com/hjl-tools/x86-psABI/wiki/x86-64-psABI-1.0.pdf
>
> 3.2.3 Parameter Passing
>
> ...
>
> Returning of Values
> The returning of values is done according to the following algorithm:
>
> ...
>
> 3.  If the class is INTEGER, the next available register of the sequenc=
e
> %rax, %rdx is used.
>
Got it, thank you.


--------------ms020609080108050805000505
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CgowggTTMIIDu6ADAgECAhBm2u8D24RhkWsluoP7F04TMA0GCSqGSIb3DQEBCwUAMH4xCzAJ
BgNVBAYTAlBMMSIwIAYDVQQKExlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEuMScwJQYDVQQL
Ex5DZXJ0dW0gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIjAgBgNVBAMTGUNlcnR1bSBUcnVz
dGVkIE5ldHdvcmsgQ0EwHhcNMTUwNDIxMTI0NTI2WhcNMjcwNjA5MTI0NTI2WjCBijELMAkG
A1UEBhMCUEwxIjAgBgNVBAoMGVVuaXpldG8gVGVjaG5vbG9naWVzIFMuQS4xJzAlBgNVBAsM
HkNlcnR1bSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEuMCwGA1UEAwwlQ2VydHVtIERpZ2l0
YWwgSWRlbnRpZmljYXRpb24gQ0EgU0hBMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAMXgVrv+CZfjKNqcnk5TvUOn3z6o4OTx4yA5BWu3CqgW7mEez4WlFuPdCVTshvZ+28Yl
5lmZ3v/44J+DCI3/nVr7729zaucJI4UsJVPYmp+5dJfy4NmraGKrhhe7GSxIPFJihexNItJF
l36wj3n1Gzggk81/i6LjT7lsDvOifiuBPxGiL4QxOxL6nQlVmydHNydqx8hA8n2GTDxIzZ6E
RQWcNLxJgHCu+BtEMP+L57n8NEjVbW/2J3pUIrS8Esm2rlkYPFF6aJON6zOWvntQ2+aenJ0x
Cip7Y+xvsL74+eVenAKRBVTMzMLevIaE799+7GkfbwYiX9j/GQorMHSzo2UCAwEAAaOCAT4w
ggE6MA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFD/KWOrxyQl+bjPBI61OrT49bEWnMB8G
A1UdIwQYMBaAFAh2zcsH/yT2xc3tu5C84oQ3RnX3MA4GA1UdDwEB/wQEAwIBBjAvBgNVHR8E
KDAmMCSgIqAghh5odHRwOi8vY3JsLmNlcnR1bS5wbC9jdG5jYS5jcmwwawYIKwYBBQUHAQEE
XzBdMCgGCCsGAQUFBzABhhxodHRwOi8vc3ViY2Eub2NzcC1jZXJ0dW0uY29tMDEGCCsGAQUF
BzAChiVodHRwOi8vcmVwb3NpdG9yeS5jZXJ0dW0ucGwvY3RuY2EuY2VyMDkGA1UdIAQyMDAw
LgYEVR0gADAmMCQGCCsGAQUFBwIBFhhodHRwOi8vd3d3LmNlcnR1bS5wbC9DUFMwDQYJKoZI
hvcNAQELBQADggEBAAu9CcEJlt/B/nZI1fXxhekorONITDb7P93cFmK7kgZ239iLT81i82C0
gjPesCQOL7LejnVmP3bM2NSLwYMiUp+pUgblyKC/5nWaRBaakyL+kfbIpd4zmaVHUK+ZMhTc
l40F6CgGLmsXlHiLqsbCVEqG1Z+wPp3Jx4aO2JyyYu3eRZbV3FapB9jUTKF2YPGU1dHbTtHN
PsSKypHEcHiuub5YNjqSe294eUupVQR4+wEHewz4OCNjFczvJ1EUj9l6v0Epl8pb+/V/QZA2
2HYN+xXkxSzwrLPDoCoMJHHse7AA533JrsRhs6t4yLwdvb3nmmajpWFqrYo++M9igLcpKmUw
ggUvMIIEF6ADAgECAhAFwgyZUkA+znWkRki3is31MA0GCSqGSIb3DQEBCwUAMIGKMQswCQYD
VQQGEwJQTDEiMCAGA1UECgwZVW5pemV0byBUZWNobm9sb2dpZXMgUy5BLjEnMCUGA1UECwwe
Q2VydHVtIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MS4wLAYDVQQDDCVDZXJ0dW0gRGlnaXRh
bCBJZGVudGlmaWNhdGlvbiBDQSBTSEEyMB4XDTE3MDUxNTExMzAyN1oXDTIwMDUxNDExMzAy
N1owTzELMAkGA1UEBhMCREUxETAPBgNVBAMMCEJhc2ljIElEMS0wKwYJKoZIhvcNAQkBFh5k
Lm1hbGtpbkByZWFsLXRpbWUtc3lzdGVtcy5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDRHXAruCn4DJ269CX1V6uryLfBC4JSwamR01xhH3MOBbyi8X0LsI34uYjYko/q
TcpIKLK5wFT8He7MAO8uUKBErTYFweeUNt7vRra44fLKUp8ntwP+PIzeyE6Uvf3HK3SMuXUY
iZCorUFy9UDxUDsv0hJkRx9XLKOiv6oY/qgEY7UJKwXesEdQ2IL8JhPeMRJmc4Hnm8NxwnXL
6wp7NOoyJjqk9msBemEmY2mQ8NW/vpocLLrqE8ndoL8XHIH0DzWFvvBBkLUL4A4MWeU7HpwF
GxIFBOujAcQFH5fzfUeAvqIUz91o2zzu4OpCGTrmBsEOvPzdmoa4vGt/2NvzVNoPAgMBAAGj
ggHJMIIBxTAMBgNVHRMBAf8EAjAAMDIGA1UdHwQrMCkwJ6AloCOGIWh0dHA6Ly9jcmwuY2Vy
dHVtLnBsL2RpY2FzaGEyLmNybDBxBggrBgEFBQcBAQRlMGMwKwYIKwYBBQUHMAGGH2h0dHA6
Ly9kaWNhc2hhMi5vY3NwLWNlcnR1bS5jb20wNAYIKwYBBQUHMAKGKGh0dHA6Ly9yZXBvc2l0
b3J5LmNlcnR1bS5wbC9kaWNhc2hhMi5jZXIwHwYDVR0jBBgwFoAUP8pY6vHJCX5uM8EjrU6t
Pj1sRacwHQYDVR0OBBYEFCPA0w6bpJTO2PoMTchRfiPdwwShMB0GA1UdEgQWMBSBEmRpY2Fz
aGEyQGNlcnR1bS5wbDAOBgNVHQ8BAf8EBAMCBLAwQgYDVR0gBDswOTA3BgwqhGgBhvZ3AgUB
BgwwJzAlBggrBgEFBQcCARYZaHR0cHM6Ly93d3cuY2VydHVtLnBsL0NQUzAdBgNVHSUEFjAU
BggrBgEFBQcDAgYIKwYBBQUHAwQwEQYJYIZIAYb4QgEBBAQDAgWgMCkGA1UdEQQiMCCBHmQu
bWFsa2luQHJlYWwtdGltZS1zeXN0ZW1zLmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAZZDLjF7T
s/BToPKetAvslJfDEEaJTeGv4Pgle1xuikqcf8zXNLwG84FBRddHE0x2/xI11WKJQz/nO1+Y
83veiM5I8dTI5nLcF34i/lu7kyHucVjorPdhJdp8N36C3HHyXpkWZZ5qDar/nAfWFhqEEZsQ
x5ChEriyly4gu+CBF99Ez2OP+dgKaCOFBC1ERExaqdj20J5Ol/5sWDASzF30xsryTs9mAl7K
ZhIbUJWfzVffH585mgLtZdcu9dCA1fk12iUvcqu3jfQKQI/fuwgB2K3LIuPbUKtt2fcnlQww
MsOQRU920a/XeelRs98keRO2VNdY9mpod3arW8ZLeoNkGjGCBA4wggQKAgEBMIGfMIGKMQsw
CQYDVQQGEwJQTDEiMCAGA1UECgwZVW5pemV0byBUZWNobm9sb2dpZXMgUy5BLjEnMCUGA1UE
CwweQ2VydHVtIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MS4wLAYDVQQDDCVDZXJ0dW0gRGln
aXRhbCBJZGVudGlmaWNhdGlvbiBDQSBTSEEyAhAFwgyZUkA+znWkRki3is31MA0GCWCGSAFl
AwQCAQUAoIICPzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0x
ODA3MjYwODEwNDJaMC8GCSqGSIb3DQEJBDEiBCCvdoPZ7Fp+rtOpP5DFE9lTkz60XnXuDiCG
bmVAC47I9zBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqG
SIb3DQMCAgEoMIGwBgkrBgEEAYI3EAQxgaIwgZ8wgYoxCzAJBgNVBAYTAlBMMSIwIAYDVQQK
DBlVbml6ZXRvIFRlY2hub2xvZ2llcyBTLkEuMScwJQYDVQQLDB5DZXJ0dW0gQ2VydGlmaWNh
dGlvbiBBdXRob3JpdHkxLjAsBgNVBAMMJUNlcnR1bSBEaWdpdGFsIElkZW50aWZpY2F0aW9u
IENBIFNIQTICEAXCDJlSQD7OdaRGSLeKzfUwgbIGCyqGSIb3DQEJEAILMYGioIGfMIGKMQsw
CQYDVQQGEwJQTDEiMCAGA1UECgwZVW5pemV0byBUZWNobm9sb2dpZXMgUy5BLjEnMCUGA1UE
CwweQ2VydHVtIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MS4wLAYDVQQDDCVDZXJ0dW0gRGln
aXRhbCBJZGVudGlmaWNhdGlvbiBDQSBTSEEyAhAFwgyZUkA+znWkRki3is31MA0GCSqGSIb3
DQEBAQUABIIBAKCK2qiGxx4mPwSrhip1hG7WKViG3994ArSCmaI4/SZ4Y4YIJcwEh5r0/K6P
IJikRxGa69NiU/VMs2c3pF13+JjSuJQ5HY+iL0LnCcjI3M+hpdjwrpiv5QTaWnDSH8dffA0I
S8eZa5KkMay64g0INvjhmUF2RXObeKw+U0wOdqYtYv6VGwMTP7Q52yNc/d0837uj5cfE+oa5
igLgR0admphA9aEzLY6ugKKoqp9bxorOf1g7RCqNu1YmNXASEcZbzXp8d72myZn+H6J+eTvV
vFftPj+vLinWnIssWJgPLPaNxwYsFfBQkmkzsH4kJ/UN3T5QcOXi91OOUdkzNWAxDp0AAAAA
AAA=
--------------ms020609080108050805000505--
