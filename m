Return-Path: <jeffrin@rajagiritech.edu.in>
ARC-Seal: i=1; a=rsa-sha256; t=1524235885; cv=none;
        d=google.com; s=arc-20160816;
        b=Sf6BJJYPpc7druFWDsCCcNALkqrorKgrLySI85W6WrJw9n7PsLTYT8dLhPYXBwQwvd
         iAdErPpFhfgNoZnt98ZfSiBudb/MCv0mogkhRBmV8HS2c/A0dv/j86qb5G598Ojy4Uf+
         GXK0hIdL+GkogkijnNyF4WUoDKDGdqsjiFJ237Lxm46OksJBN+BvYGFtPyUuksZPW3pI
         kcA+pCA3UtrcZzsY/3kKkDJ+FkYVJdXoOZnafXin8t6e8o2WAlmPTn0cXfDHh3vVoKRN
         FoNMf96TeqQTPqEnVrMzPLhDNKVgV0YIg8Ung7vHnETjCqd2oL3da0at+m1ca61ChPGG
         wY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=4Ly5/zTPxndVOyXl8K3J5cvg/ciX9CI1IB9nOuJ6sNc=;
        b=cVdmNearcVDFQdRxWTwQfK60Z+tfPMh+q/NqvbUNp9FgYQD/IbWBeX4MR8tF5ZqgQ3
         3Iw4UK+zgSSoM9UUWcqQHsQ+cPGybhzItKPSyiqcm7YDYvYOG6BljnSI2ZqwaieiH8rz
         hJ/ByOSe1K+unGXfeDE/UpQDNI1mh46pmFJYtChZU+gHeTUDhphd4kdiqFwnp4xRJuyJ
         tfRMCGip6sNCZuodwsLUkVDx7RKH1SYt6vxPhICij2w/tdRjGBSK9PrGvcvMcsMJmrL5
         +NkViQVAJf5LNu5ncrRRStBZkS3ARaMiyGNMwC/1mQIXYCTJ7NgZ0y7QiJPo+B+q5D9D
         pWBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=meReGjzp;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of jeffrin@rajagiritech.edu.in) smtp.mailfrom=jeffrin@rajagiritech.edu.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.s=20150623 header.b=meReGjzp;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of jeffrin@rajagiritech.edu.in) smtp.mailfrom=jeffrin@rajagiritech.edu.in
X-Google-Smtp-Source: AB8JxZqS3iFlLhMTSuMR4FRMCAsj/c/cuSH5A67VJ++lNaK6hH/+8BbOUDDfRG16Rl/VjRSwI2UV85Li+bLTqv92+EE=
MIME-Version: 1.0
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 20 Apr 2018 20:21:24 +0530
Message-ID: <CAG=yYwmC1G_nb-gZ6F+9-=nRUeaPt3vRfLM4UETPd2h-XObVfA@mail.gmail.com>
Subject: PROBLEM: error due to conflicting types during build of kselftests
To: shuah@kernel.org, mingo@kernel.org, tglx@linutronix.de,
	dave.hansen@linux.intel.com, kstewart@linuxfoundation.org,
	pombredanne@nexb.com, gregkh@linuxfoundation.org, ebiederm@xmission.com,
	luto@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a1147e7a271d5de056a48d26a"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598277167632272926?=
X-GMAIL-MSGID: =?utf-8?q?1598277167632272926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a1147e7a271d5de056a48d26a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

the following is the error found...
---------------------------------------------------------------------------=
--------
protection_keys.c:421:5: error: conflicting types for =E2=80=98pkey_set=E2=
=80=99
 int pkey_set(int pkey, unsigned long rights, unsigned long flags)
     ^~~~~~~~
---------------------------------------------------------------------------=
---------

to reproduce this error...

make -C tools/testing/selftests

Details about software:

Linux debian 4.17.0-rc1+ #1 SMP Thu Apr 19 18:59:45 IST 2018 x86_64
GNU/Linux

GNU Make            4.2.1
Binutils            2.30
Util-linux          2.31.1
Mount                2.31.1
Linux C Library      2.27
Dynamic linker (ldd) 2.27
readlink: missing operand
Try 'readlink --help' for more information.
Procps              3.3.14
Kbd                  2.0.4
Console-tools        2.0.4
Sh-utils            8.28
Udev                238

--=20
software engineer
rajagiri school of engineering and technology

--001a1147e7a271d5de056a48d26a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hello,<div><br></div><div><div>the following is the error =
found...</div><div>--------------------------------------------------------=
---------------------------</div><div>protection_keys.c:421:5: error: confl=
icting types for =E2=80=98pkey_set=E2=80=99</div><div>=C2=A0int pkey_set(in=
t pkey, unsigned long rights, unsigned long flags)</div><div>=C2=A0 =C2=A0 =
=C2=A0^~~~~~~~</div></div><div>--------------------------------------------=
----------------------------------------</div><div><br></div><div>to reprod=
uce this error...</div><div><pre style=3D"box-sizing:border-box;font-family=
:Consolas,&quot;Andale Mono WT&quot;,&quot;Andale Mono&quot;,&quot;Lucida C=
onsole&quot;,&quot;Lucida Sans Typewriter&quot;,&quot;DejaVu Sans Mono&quot=
;,&quot;Bitstream Vera Sans Mono&quot;,&quot;Liberation Mono&quot;,&quot;Ni=
mbus Mono L&quot;,Monaco,&quot;Courier New&quot;,Courier,monospace;font-siz=
e:12px;white-space:pre;margin:0px;padding:12px;line-height:normal;display:b=
lock;overflow:auto;color:rgb(64,64,64);font-style:normal;font-variant-ligat=
ures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;=
text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;backg=
round-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-=
color:initial">make -C tools/testing/selftests </pre></div><div>Details abo=
ut software:</div><div><br></div><div><div>Linux debian 4.17.0-rc1+ #1 SMP =
Thu Apr 19 18:59:45 IST 2018 x86_64 GNU/Linux</div><div><br></div><div>GNU =
Make=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"white-space:pr=
e">	</span>4.2.1</div><div>Binutils=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <span style=3D"white-space:pre">	</span>2.30</div><div>Util-linux=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=3D"white-space:pre">	</span>2.31.1=
</div><div>Mount=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<spa=
n style=3D"white-space:pre">	</span>2.31.1</div><div>Linux C Library=C2=A0 =
=C2=A0 =C2=A0<span style=3D"white-space:pre">	</span>2.27</div><div>Dynamic=
 linker (ldd)<span style=3D"white-space:pre">	</span>2.27</div><div>readlin=
k: missing operand</div><div>Try &#39;readlink --help&#39; for more informa=
tion.</div><div>Procps=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <spa=
n style=3D"white-space:pre">	</span>3.3.14</div><div>Kbd=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<span style=3D"white-space:pre=
">	</span>2.0.4</div><div>Console-tools=C2=A0 =C2=A0 =C2=A0 =C2=A0<span sty=
le=3D"white-space:pre">	</span>2.0.4</div><div>Sh-utils=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 <span style=3D"white-space:pre">	</span>8.28</div><di=
v>Udev=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <span style=
=3D"white-space:pre">	</span>238</div></div><div><br></div><div>-- <br><div=
 class=3D"gmail_signature"><div dir=3D"ltr">software engineer<div>rajagiri =
school of engineering and technology</div></div></div>
</div></div>

--001a1147e7a271d5de056a48d26a--
