Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9102C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E25020859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="Z9/w4NVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbfAPKQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:16:14 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:55601 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731883AbfAPKQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:16:13 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 43fjlt5fS1z1yjf;
        Wed, 16 Jan 2019 11:16:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1547633770; bh=+dcgOxWBTGP/4hIlpzluyMCxMkZcJkS62gFrGaTOu0I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From:To:CC:
         Subject;
        b=Z9/w4NVNEmos3rVXDNuegUaS0cOOaErdrNJ9bMHo/j11n35W6n8tYSDdVT/HDhCNi
         OuuFO5Big0Ej01GnlDDz5yN5Jmy/R9UCZ4niedEjX0bBqr28M1RcvVtnlYrhzjytKc
         91DcWj9tGEoZQuLmcXcaC2/uWSJFj2vnZifK+j18Bl962DyGu3BGyuYv0ezxqfy9OP
         hyNuW/ImGCfLI9V7k0FLUHHT61YxD+xTmZf498y6MGX5dzQKZqGXtYw6sSkeKB043A
         wXVayJ0V2YpX9rmaWy3jjG33TIM6TJL7I3Phjr4z7WUOvpsgh54mpIu0c62D8diC2r
         NweEoPKB8hjsw==
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:638:a000:4142::ffff:149
Received: from [IPv6:2001:638:a000:4142::ffff:149] (faui49copter1.informatik.uni-erlangen.de [IPv6:2001:638:a000:4142::ffff:149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/gDfQhO+iv06DkzYj/henCKaXBeWYmndU=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 43fjlr0b96z1yhF;
        Wed, 16 Jan 2019 11:16:08 +0100 (CET)
Subject: Re: uprobes: bug in comm/string output?
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <bf358673-ceb2-65bf-80c9-4b1c09a8a264@fau.de>
 <8b67136d-28d7-a734-6366-9511e30d66a7@fau.de>
 <20190116190054.ac22c8495540578834446236@kernel.org>
From:   Andreas Ziegler <andreas.ziegler@fau.de>
Message-ID: <62276858-9135-2393-8993-64e1088db7b9@fau.de>
Date:   Wed, 16 Jan 2019 11:16:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116190054.ac22c8495540578834446236@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000801060005020805080807"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000801060005020805080807
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for your reply!

On 1/16/19 11:00 AM, Masami Hiramatsu wrote:
> On Tue, 15 Jan 2019 14:36:48 +0100
> Andreas Ziegler <andreas.ziegler@fau.de> wrote:
>=20
>> Hi again,
>>
>> On 1/14/19 1:38 PM, Andreas Ziegler wrote:
>>> Hi,
>>>
>>> I've been playing around with uprobes today and found the following w=
eird behaviour/output when using more than one string argument (or using =
the $comm argument). This was run on a v4.20 mainline build on Ubuntu 18.=
04.
>>>
>>> root@ubuntu1810:~# uname -a
>>> Linux ubuntu1810 4.20.0-042000-generic #201812232030 SMP Mon Dec 24 0=
1:32:58 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> I'm trying to track calls to dlopen so I'm looking up the correct off=
set in libdl.so:
>>>
>>> root@ubuntu1810:/sys/kernel/debug/tracing# readelf -s /lib/x86_64-lin=
ux-gnu/libdl-2.28.so | grep dlopen
>>>      34: 00000000000012a0   133 FUNC    GLOBAL DEFAULT   14 dlopen@@G=
LIBC_2.2.5
>>>
>>> Then I'm creating a uprobe with two prints of $comm and two prints of=
 the first argument to dlopen, and enable that probe. The '/root/test' pr=
ogram only does a dlopen("libc.so.6", RTLD_LAZY) in main().
>>>
>>> root@ubuntu1810:/sys/kernel/debug/tracing# echo 'p:dlopen /lib/x86_64=
-linux-gnu/libdl-2.28.so:0x12a0 $comm $comm +0(%di):string +0(%di):string=
' > uprobe_events
>>> root@ubuntu1810:/sys/kernel/debug/tracing# echo 1 > events/uprobes/dl=
open/enable
>>> root@ubuntu1810:/sys/kernel/debug/tracing# /root/test
>>>
>>> The trace output looks like this:
>>>
>>> root@ubuntu1810:/sys/kernel/debug/tracing# cat trace
>>> # tracer: nop
>>> #
>>> #                              _-----=3D> irqs-off
>>> #                             / _----=3D> need-resched
>>> #                            | / _---=3D> hardirq/softirq
>>> #                            || / _--=3D> preempt-depth
>>> #                            ||| /     delay
>>> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
>>> #              | |       |   ||||       |         |
>>>              test-1617  [000] d...  1237.959168: dlopen: (0x7fbd5272e=
2a0) arg1=3D(fault) arg2=3D(fault) arg3=3D"libc.so.6libc.so.6" arg4=3D"li=
bc.so.6"
>>>
>>> That's very weird for two reasons:
>>> - fetching $comm seems to fail with an invalid pointer
>>> - arg3 contains the text twice (if I add another print of the argumen=
t, arg3 will contain the wanted string three times, arg4 two times and th=
e last argument will contain it once).
>>
>> at least for the second problem I think I found the answer, and for th=
e
>> first problem I have a suspicion (see last paragraph for that).
>=20
> OK, this looks broken. Thank you very much for reporting it!
>=20
> BTW, I tried to reproduce it with kprobe event, but it seems working we=
ll. e.g.
>=20
>   # echo 'p ksys_chdir $comm $comm +0(%di):string +0(%di):string' > kpr=
obe_events
>   # echo 1 > events/kprobes/enable
>   # cd /sys/kernel/debug/tracing
>   # cat trace
>                sh-812   [003] ...1   229.344360: p_ksys_chdir_0: (ksys_=
chdir+0x0/0xc0) arg1=3D"sh" arg2=3D"sh" arg3=3D"/sys/kernel/debug/tracing=
" arg4=3D"/sys/kernel/debug/tracing"
>=20
> So, it might be an issue on uprobe_event.
>=20

yes, kprobes work because they use strncpy_from_unsafe which *includes*=20
the null byte in its return value... the fact that both are called=20
strncpy_* but behave differently is really annoying...

I just sent a patch for this case half an hour ago which simply adds 1=20
to the returned value for uprobes if it didn't hit the maximum allowed=20
length.

>>
>> For this, I installed a uprobe for libdl.so/dlopen once again, the
>> command would be
>>
>> 'p:dlopen /lib/x86_64-linux-gnu/libdl-2.28.so:0x12a0 $comm $comm'
>>
>> so it should print the process name twice (using a kernel v4.18 on
>> Ubuntu 18.10).
>>
>> The code which prints the collected data (print_type_string, defined b=
y
>> PRINT_TYPE_FUNC_NAME(string) in kernel/trace/trace_probe.c) is the
>> following, it simply passes the respective data to trace_seq_printf wi=
th
>> a "%s" format string:
>>
>> int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void=
 *ent)
>> {
>>           int len =3D *(u32 *)data >> 16;
>>
>>           if (!len)
>>                   trace_seq_puts(s, "(fault)");
>>           else
>>                   trace_seq_printf(s, "\"%s\"",
>>                                    (const char *)get_loc_data(data, en=
t));
>>           return !trace_seq_has_overflowed(s);
>> }
>>
>> I dug into that function with KGDB and found the following: 'data' hol=
ds
>> the size and offset for the member in question, which is 0xf and 0x18,=

>> respectively. 'ent' holds the base address for event. When we print th=
e
>> string at ent + 0x18, we can see that the output for 'arg1' will be
>> "update-notifierupdate-notifier"
>>
>> Thread 511 hit Breakpoint 6, print_type_string (s=3D0xffff880078fd1090=
,
>> name=3D0xffff880078fe4458 "arg1", data=3D0xffff88007d01f05c,
>> ent=3D0xffff88007d01f04c) at
>> /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c:67
>> 67	in /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c
>> gdb$ p *(uint32_t *) data
>> $46 =3D 0xf0018
>> gdb$ p ent
>> $47 =3D (void *) 0xffff88007d01f04c
>> gdb$ p ((char *)ent + 0x18)
>> $48 =3D 0xffff88007d01f064 "update-notifierupdate-notifier"
>>
>> Moving on printing 'arg2' (e.g., the other $comm string). Here we see
>> that the string in question is at offset 0x27, and if we print that, w=
e
>> see the correct "update-notifier".
>>
>> Thread 511 hit Breakpoint 6, print_type_string (s=3D0xffff880078fd1090=
,
>> name=3D0xffff880078fe4d70 "arg2", data=3D0xffff88007d01f060,
>> ent=3D0xffff88007d01f04c) at
>> /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c:67
>> 67	in /build/linux-EsXT4r/linux-4.18.0/kernel/trace/trace_probe.c
>> gdb$ p *(uint32_t *) data
>> $49 =3D 0xf0027
>> gdb$ p ((char *)ent + 0x27)
>> $50 =3D 0xffff88007d01f073 "update-notifier"
>>
>> Looking at the bytes in memory and the offsets it becomes clear that
>> there is no \0 byte at the end of the first entry (which would need to=

>> be at address 0xffff88007d01f064 + 0xf =3D 0xffff88007d01f073 but inst=
ead
>> that's the start address of the second entry which simply gets consume=
d
>> by the (first) "%s" as well.
>>
>> gdb$ x/32x ent
>> 0xffff88007d01f04c:	0x00010592	0x00002143	0xe83522a0	0x00007f7f
>> 0xffff88007d01f05c:	0x000f0018	0x000f0027	0x61647075	0x6e2d6574
>> 0xffff88007d01f06c:	0x6669746f	0x75726569	0x74616470	0x6f6e2d65
>> 0xffff88007d01f07c:	0x69666974	0x00007265	0x0045feee	0x00010592
>> 0xffff88007d01f08c:	0x00002143	0xe83522a0	0x00007f7f	0x000f0018
>> 0xffff88007d01f09c:	0x000f0027	0x61647075	0x6e2d6574	0x6669746f
>> 0xffff88007d01f0ac:	0x75726569	0x74616470	0x6f6e2d65	0x69666974
>> 0xffff88007d01f0bc:	0x00007265	0x0038806e	0x00010592	0x00002143
>>
>> Should we simply also store the terminating \0 at the end of the strin=
g?
>> The $comm string is saved by fetch_comm_string (in v4.18) which uses
>> 'strlcpy' and its return value as the size of the respective data...
>> that value however does NOT include the terminating \0 byte (as it's
>> simply the return value of a call to strlen). The same holds for
>> "regular" string arguments where the code uses 'strncpy_from_user' whi=
ch
>> has the same return value semantics. Or should we use the information =
in
>> 'len' to only print that many characters?
>>
>> As fetch_store_string has changed between v4.18 and v4.20, I could try=

>> to reproduce this with a v4.20 kernel but from looking at the code I
>> suspect this should be the problem in v4.20 as well.
>>
>> As for $comm only printing "(fault)" I suspect this has to do with
>> commit 533059281ee5 ("tracing: probeevent: Introduce new argument
>> fetching code") as we lost the 'fetch_comm_string' function in that
>> commit and (I think, didn't have the newer kernel running yet) go
>> through 'fetch_store_string' now. This calls 'strncpy_from_user' inste=
ad
>> of accessing current->comm directly (and thus does not succeed in
>> fetching it). I'm adding Masami to Cc: as the author of said patch.
>=20
> Ah, OK. I have to check fetch_store_string() implementation differences=

> between trace_kprobe.c and trace_uprobe.c. Well, in the uprobes, we may=

> need more careful steps.
>=20

I went into this a bit deeper today, and right now it is simply failing=20
to parse the code because there is no FETCH_OP_COMM case in=20
process_fetch_insn() for uprobes so that will return -EILSEQ, leading to =

a make_data_loc(0, ...) in store_trace_args(). If we just add=20
FETCH_OP_COMM and let val point to current->comm (that's what=20
trace_kprobe.c does), we get an -EFAULT return value from=20
fetch_store_string because strncpy_from_user() checks if the argument is =

in user space.

So I think we might need a special case for that, something like=20
FETCH_OP_ST_COMM_STRING which is only used for FETCH_OP_COMM and copies=20
current->comm over to the dynamic area. The implementation could be=20
similar to the old fetch_comm_string implementation before your rewrite.

> Anyway, that is my fault. I will fix the issue. Hmm, and I may need to
> consider to add some test program for uprobes, which including a target=

> application to be probed.
>=20
> Thank you!
>

Thanks, let me know if I can help you.

Andreas


--------------ms000801060005020805080807
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ELswggTVMIIDvaADAgECAghQTsb1PRG0ZDANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJE
RTEcMBoGA1UEChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRy
dXN0IENlbnRlcjEjMCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQw
NzIyMTIwODI2WhcNMTkwNzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZO
LVZlcmVpbjEQMA4GA1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xv
YmFsIC0gRzAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTD
llA1PWLpbkztlNcAW5UidNQg6zSP1uzAMQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1
OXstkEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOCJEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8B
r3QPwQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJlYE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9
bzOz2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuLFlZWQ8/h1RM9ph8nMM1JVNvJEzSa
cXXFbOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4IBhjCCAYIwDgYDVR0PAQH/BAQD
AgEGMB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNVHSMEGDAWgBQxw3kbuvVT
1xfgiXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMGIGA1UdIARbMFkwEQYPKwYBBAGB
rSGCLAEBBAICMBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIsAQEEAwEwDwYNKwYB
BAGBrSGCLAEBBDANBgsrBgEEAYGtIYIsHjA+BgNVHR8ENzA1MDOgMaAvhi1odHRwOi8vcGtp
MDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmwweAYIKwYBBQUHAQEEbDBqMCwG
CCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9vY3NwcjA6BggrBgEFBQcw
AoYuaHR0cDovL3BraTAzMzYudGVsZXNlYy5kZS9jcnQvRFRfUk9PVF9DQV8yLmNlcjANBgkq
hkiG9w0BAQsFAAOCAQEAYyAo/ZwhhnK+OUZZOTIlvKkBmw3Myn1BnIZtCm4ssxNZdbEzkhth
Jxb/w7LVNYL7hCoBSb1mu2YvssIGXW4/buMBWlvKQ2NclbbhMacf1QdfTeZlgk4y+cN8ekvN
TVx07iHydQLsUj7SyWrTkCNuSWc1vn9NVqTszC/Pt6GXqHI+ybxA1lqkCD3WvILDt7cyjrEs
jmpttzUCGc/1OURYY6ckABCwu/xOr24vOLulV0k/2G5QbyyXltwdRpplic+uzPLl2Z9Tsz6h
L5Kp2AvGhB8Exuse6J99tXulAvEkxSRjETTMWpMgKnmIOiVCkKllO3yG0xIVIyn8LNrMOVtU
FzCCBYUwggRtoAMCAQICBxekJTUNxL8wDQYJKoZIhvcNAQELBQAwWjELMAkGA1UEBhMCREUx
EzARBgNVBAoTCkRGTi1WZXJlaW4xEDAOBgNVBAsTB0RGTi1QS0kxJDAiBgNVBAMTG0RGTi1W
ZXJlaW4gUENBIEdsb2JhbCAtIEcwMTAeFw0xNDA1MjcxNDU2MzdaFw0xOTA3MDkyMzU5MDBa
MIGjMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJuMREwDwYDVQQHEwhFcmxhbmdlbjEo
MCYGA1UEChMfVW5pdmVyc2l0YWV0IEVybGFuZ2VuLU51ZXJuYmVyZzENMAsGA1UECxMEUlJa
RTEPMA0GA1UEAxMGRkFVLUNBMSYwJAYJKoZIhvcNAQkBFhdjYUBycnplLnVuaS1lcmxhbmdl
bi5kZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALeM6O3UbAkUYBzi+4jBEF8F
klzGxWvAHHou8+iNKcRVMU9fMiuJ/n4KuH/3AgzGloyieClmOqe/KlIhWURtMwsOmD3rMclX
p9ilG7eIU70uE82az1Cw7N2V3o9tlIPlDH61ZXK8XCQO05u/zubqLREeOidcV+irlur548hu
y+iURMGuowGgH1tm9l1X3735XqkvkFwnUzUkhFiABwtajxIZ022gMCJba5RXj+LSZv+67MPT
qQmdoMf3WSs8zpM854+RSSPNbinKDo4KARkfaNkTib36HPMfMTu5ViBR5TIuRJ/gAHtV3YC+
Uccjpj/y4XUN+EoqsqODlFsVv994KAkCAwEAAaOCAgQwggIAMBIGA1UdEwEB/wQIMAYBAf8C
AQEwDgYDVR0PAQH/BAQDAgEGMBEGA1UdIAQKMAgwBgYEVR0gADAdBgNVHQ4EFgQU9HPz+sZC
s8ZcacBYvnQ4+WErjmIwHwYDVR0jBBgwFoAUSbfGz+g9H3/qRHsTKffxCnA+3mQwIgYDVR0R
BBswGYEXY2FAcnJ6ZS51bmktZXJsYW5nZW4uZGUwgYgGA1UdHwSBgDB+MD2gO6A5hjdodHRw
Oi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jcmwvY2FjcmwuY3JsMD2g
O6A5hjdodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jcmwvY2Fj
cmwuY3JsMIHXBggrBgEFBQcBAQSByjCBxzAzBggrBgEFBQcwAYYnaHR0cDovL29jc3AucGNh
LmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEcGCCsGAQUFBzAChjtodHRwOi8vY2RwMS5wY2Eu
ZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBHBggrBgEFBQcw
AoY7aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9wdWIvY2FjZXJ0L2Nh
Y2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAAvdv5tQXS8Y3D2t/HCEcmY7UzcK/b8XU6IY
0o8b25SNIVX0qkNyC6nkx2NJNpas2cCVs5PgKmAV59oCiNupcUBJ126wiTlzuy4wI1YSJgHw
PX0rEMLefI/6YAfxgCqH0fcRy0WS845CSZNY7raVwyZBjrvCYio0i2jmniSAT6RPfWATXsrB
l3gmfBtJ7OFt0l1zLeKhhPhMeIUMojGUKsdyMslBC6Qm5UDA/N683/eGCfk3KOwKVQZ06hml
bEDwfa8j70R3XFmOVDCKcXJWlTRA/TAExQCz4Y0AWoZJ76PdMzQtjIKpvBq2Kh4L8D5azsp0
lBqMJ/8X8jD51omx47cwggZVMIIFPaADAgECAgwclFi/j/PFlOAOvOwwDQYJKoZIhvcNAQEL
BQAwgaMxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIEwZCYXllcm4xETAPBgNVBAcTCEVybGFuZ2Vu
MSgwJgYDVQQKEx9Vbml2ZXJzaXRhZXQgRXJsYW5nZW4tTnVlcm5iZXJnMQ0wCwYDVQQLEwRS
UlpFMQ8wDQYDVQQDEwZGQVUtQ0ExJjAkBgkqhkiG9w0BCQEWF2NhQHJyemUudW5pLWVybGFu
Z2VuLmRlMB4XDTE3MDExMDEzMDEzNVoXDTE5MDcwOTIzNTkwMFowgaAxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCEVybGFuZ2VuMTwwOgYDVQQKDDNGcmllZHJp
Y2gtQWxleGFuZGVyLVVuaXZlcnNpdGFldCBFcmxhbmdlbi1OdWVybmJlcmcxFTATBgNVBAsM
DEluZm9ybWF0aWsgNDEYMBYGA1UEAwwPQW5kcmVhcyBaaWVnbGVyMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAmtyQgCgFPnLKIEH2ckMjkdT6/Z9QqAOAvLrD3CPGYVBjX60K
D/vNCSxjmiljAIgA12c8atTvXjm0MPicbp6G1HAwiOZHompyuab7gF8lMiR+6aQTNwawwMRY
lEeuXVxslwVu4kMu4N5AVid2VRgnodtMdEWzhlnRF1Z4wuY9egLYdZjVVJyWKPGDrgvREn9U
P5wjvR2IjnrrjXBcEb1StUIYnQGIWySb+TjNd+LAlFy6mBVWiDOaHZO7VTZmwQOl/ezw+8LZ
b7aVxTPZsJV/Jx4sNDt1XextSSCnGDYUVGSlOhNOeFzJufdNwW6O7ZlS/DT3d1/OLcjf37SA
XWB/qwIDAQABo4ICiDCCAoQwQAYDVR0gBDkwNzARBg8rBgEEAYGtIYIsAQEEAwUwEQYPKwYB
BAGBrSGCLAIBBAMBMA8GDSsGAQQBga0hgiwBAQQwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMC
BeAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBTgq5FcX/tTXVoT
pjxFcHQMQIw8NzAfBgNVHSMEGDAWgBT0c/P6xkKzxlxpwFi+dDj5YSuOYjA0BgNVHREELTAr
gRZhbmRyZWFzLnppZWdsZXJAZmF1LmRlgRF6aWVnbGVyQGNzLmZhdS5kZTCBnwYDVR0fBIGX
MIGUMEigRqBEhkJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL3VuaS1lcmxhbmdlbi1udWVybmJl
cmctY2EvcHViL2NybC9jYWNybC5jcmwwSKBGoESGQmh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUv
dW5pLWVybGFuZ2VuLW51ZXJuYmVyZy1jYS9wdWIvY3JsL2NhY3JsLmNybDCB7QYIKwYBBQUH
AQEEgeAwgd0wMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5kZm4uZGUvT0NTUC1TZXJ2
ZXIvT0NTUDBSBggrBgEFBQcwAoZGaHR0cDovL2NkcDEucGNhLmRmbi5kZS91bmktZXJsYW5n
ZW4tbnVlcm5iZXJnLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBSBggrBgEFBQcwAoZGaHR0
cDovL2NkcDIucGNhLmRmbi5kZS91bmktZXJsYW5nZW4tbnVlcm5iZXJnLWNhL3B1Yi9jYWNl
cnQvY2FjZXJ0LmNydDANBgkqhkiG9w0BAQsFAAOCAQEAeakOmEmyphLw/P5o/WzEtqrvAa1/
JhcrbhqS4z+3ffCBxr6vz0Corp4ZqRv5mZ4aPQtP65/w/n28lFQm3AphDnmZCvUB3bH21BM1
aHOU3vGPTjuK7Ae/E9m77CbVTqnpOed7Dg2mBgy2PcdWOlqoNweM8AWEb3thsPcCdk1AueqZ
3Mp89KOHzj5wklaDyaA2k+qJdsf9GSdvXvYmoF1g9RgPPVFhwjfmgsixfTYD69E9SNVWP56B
/iQBm3wPeU+C2e8JGbAnjEoS7mOvrloGqjfpsQ7vg8vYmMwd1fu1ImLrYfxMU3wPsnv1hOd+
uGVmBu8Qu8FqH8mmhbYmwiUiUDGCBE0wggRJAgEBMIG0MIGjMQswCQYDVQQGEwJERTEPMA0G
A1UECBMGQmF5ZXJuMREwDwYDVQQHEwhFcmxhbmdlbjEoMCYGA1UEChMfVW5pdmVyc2l0YWV0
IEVybGFuZ2VuLU51ZXJuYmVyZzENMAsGA1UECxMEUlJaRTEPMA0GA1UEAxMGRkFVLUNBMSYw
JAYJKoZIhvcNAQkBFhdjYUBycnplLnVuaS1lcmxhbmdlbi5kZQIMHJRYv4/zxZTgDrzsMA0G
CWCGSAFlAwQCAQUAoIICaTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0xOTAxMTYxMDE2MDdaMC8GCSqGSIb3DQEJBDEiBCAYSDkqEEmwaJUILgaNQxpEwraR
vpQX8ddQeYRs9fwBTTBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQME
AQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIH
MA0GCCqGSIb3DQMCAgEoMIHFBgkrBgEEAYI3EAQxgbcwgbQwgaMxCzAJBgNVBAYTAkRFMQ8w
DQYDVQQIEwZCYXllcm4xETAPBgNVBAcTCEVybGFuZ2VuMSgwJgYDVQQKEx9Vbml2ZXJzaXRh
ZXQgRXJsYW5nZW4tTnVlcm5iZXJnMQ0wCwYDVQQLEwRSUlpFMQ8wDQYDVQQDEwZGQVUtQ0Ex
JjAkBgkqhkiG9w0BCQEWF2NhQHJyemUudW5pLWVybGFuZ2VuLmRlAgwclFi/j/PFlOAOvOww
gccGCyqGSIb3DQEJEAILMYG3oIG0MIGjMQswCQYDVQQGEwJERTEPMA0GA1UECBMGQmF5ZXJu
MREwDwYDVQQHEwhFcmxhbmdlbjEoMCYGA1UEChMfVW5pdmVyc2l0YWV0IEVybGFuZ2VuLU51
ZXJuYmVyZzENMAsGA1UECxMEUlJaRTEPMA0GA1UEAxMGRkFVLUNBMSYwJAYJKoZIhvcNAQkB
FhdjYUBycnplLnVuaS1lcmxhbmdlbi5kZQIMHJRYv4/zxZTgDrzsMA0GCSqGSIb3DQEBAQUA
BIIBAC3fUkSwqdWP3Fl+eQHlYNGHF7zT3Vyh0fQ1u6ChGA6rSVp6xc9id5ioOqD08rkcMuJn
hQbuVdjYeQ3u3XabpcLmaLpy0Aa4ZhXrFfxasOZTnrey7XsrE3Yv6xsoLVLPjdXt9mnSHID8
78ZuIFLeB48elrMaV3PYtidj9UxOpb5pbWCZPaAd1sh2uG6iAnG7VvUvAuZxaprUMtXFrS7Z
iYFQdEVlg/X+H70NXoEHsuf+mT9aRFsM/E+0DpCyAV5+zv6K/DRa9s4FgAyHPg9pyY9EL2pO
LIDLANhR1CFS+jZDqIanIbzvTTw2DxgwtG3ansz8cnH/T9nN9xACnZAAwHsAAAAAAAA=
--------------ms000801060005020805080807--
