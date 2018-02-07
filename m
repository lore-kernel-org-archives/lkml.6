Return-Path: <l4stpr0gr4m@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518002777; cv=none;
        d=google.com; s=arc-20160816;
        b=B4QZI8ol6t1DZuLoliRNAjYWiKISq+jsv1tiuMdHUuGSxoPSIOsrbMHGvJ1EHEPP3m
         m4JBPkQUPw4z+rts6N3Bs6xuuFthWvBixroZ/C1hSpksZ+PsxK78CpJ03GsefHmawAI7
         mOROQ/B1r0vl5GvLCjUlKPXmCbHQ9meH5AYQ85BsXERJ5XvtaGxjGsjmJTlDz9IHjgsw
         OMEqAHkxpdhG/40QBbFv4aaXwaAC7ieRNJ1jhJ/idERaSSWtSHZkO+SACljuUJFWgX4B
         5tNJAAZvbPizAbp6xWxOz7APO265jgRnlBqngpFn6S2MLKKJ/ZTG+jmwdLADPe70q9X3
         e9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=whWL/jpe0kDtGREYS4rED6MAO2jQk9w1VPEb8q128cE=;
        b=bXvbD7yScp0njXwRbufZIlHRiAgIUU6PcDLSCUe44+j2S8IP1eUALcvyspfV/7Myij
         wkRvybmyOtOVkyk50DXbQUGv7+9NdMdiBchtAsSn/s7glXzAgR6I1ScNkqjloDbhPidQ
         snhL+wjTbcGRseUxWtAfsULHdvNv18YzIm5J3IZPgIjBLJyNQ/n5kfL4iyDUiS/gDK0A
         GmzXNOhN5QJpYtuSB9O6m8iSbxD2P8MYlUq/MckDpbjS6VmqRfF0zOkTMtp/ZFPzvKhH
         9QQ0336LlYzcQWzDRUQwsJE0HoYkdVBWtlEjtFG67o5Rn/1U8lby/QIfhjHT6gDbofx2
         pNZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=okXInZVK;
       spf=pass (google.com: domain of l4stpr0gr4m@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=l4stpr0gr4m@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=okXInZVK;
       spf=pass (google.com: domain of l4stpr0gr4m@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=l4stpr0gr4m@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225zwxYDM4/B8MzyROqmwD4IxI6oNHxo5d+bfbZLXWc7qzfgQ4pcMMWjjYeT9z/3t+809ISaC6VvhTJrMyljWQk=
MIME-Version: 1.0
In-Reply-To: <20180207110926.dzokcw2dwlinh2io@mwanda>
References: <1517952214-3434-1-git-send-email-l4stpr0gr4m@gmail.com> <20180207110926.dzokcw2dwlinh2io@mwanda>
From: Kangmin Park <l4stpr0gr4m@gmail.com>
Date: Wed, 7 Feb 2018 20:26:16 +0900
Message-ID: <CAKW4uUz0X4h7=n+vnRGbe3uuOTChuSMjasbSBFPcxC-MYRh1vg@mail.gmail.com>
Subject: Re: [PATCH] Update rf_type_definition
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, justin@jvreeland.com, davem@davemloft.net,
	hdegoede@redhat.com, himanshujha199640@gmail.com, hadess@hadess.net,
	joe@perches.com, colin.king@canonical.com, Larry.Finger@lwfinger.net
Content-Type: multipart/alternative; boundary="001a1148cede4751ce05649d90df"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591688275498143058?=
X-GMAIL-MSGID: =?utf-8?q?1591741280508349361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a1148cede4751ce05649d90df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your feedback. I learned a lot.
I thought I had to fix all warnings by checkpatch.pl.
If the patch is not good, I'll resubmit patch v3 which just fix space
required error by checkpatch later.

Regards.
Kangmin Park.


2018. 2. 7. =EC=98=A4=ED=9B=84 8:14=EC=97=90 "Dan Carpenter" <dan.carpenter=
@oracle.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

This is better.  But the subject should say [PATCH v2] and we need a
driver prefix.

On Wed, Feb 07, 2018 at 06:23:34AM +0900, l4stpr0gr4m@gmail.com wrote:
> From: Kangmin Park <l4stpr0gr4m@gmail.com>
>
> enum RT_RF_TYPE_DEFINITION on rtl8723bs/include/rtw_rf.h
> is different from enum tag_HAL_RF_Type_Definition on
> rtl8723bs/include/HalVerDef.h
>
> So, update them to be the same reference from
> enum rf_type on rtlwifi/wifi.h which recent version.
>
> As a result, ODM_RF_TYPE_E needs to be updated as well
> Therefore, it is updated reference from enum odm_rf_type
> on rtlwifi/phydm/phydm_pre_define.h too.
> And update some additional code to check more
> chip versions that resulted from it.
>
> Also, fixed some space required errors and
> line over 80 characters warnings by checkpatch.pl.

Don't do this.  It's considered unrelated white space change and it
makes the code hard to review.

To be honest, I don't know the code well enough to say if this patch is
a good idea generally...  It seems risky and I wish someone would test
it or a maintainer would Ack it.

regards,
dan carpenter

--001a1148cede4751ce05649d90df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Thank you for your feedback. I learned a lot.<div di=
r=3D"auto">I thought I had to fix all warnings by <a href=3D"http://checkpa=
tch.pl">checkpatch.pl</a>.</div><div dir=3D"auto">If the patch is not good,=
 I&#39;ll resubmit patch v3 which just fix space required error by checkpat=
ch later.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards.</div>=
<div dir=3D"auto">Kangmin Park.</div><br><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">2018. 2. 7. =EC=98=A4=ED=9B=84 8:14=EC=97=90 &quot;=
Dan Carpenter&quot; &lt;<a href=3D"mailto:dan.carpenter@oracle.com">dan.car=
penter@oracle.com</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br type=3D"=
attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">This is better.=C2=A0 But the subject=
 should say [PATCH v2] and we need a<br>
driver prefix.<br>
<div class=3D"quoted-text"><br>
On Wed, Feb 07, 2018 at 06:23:34AM +0900, <a href=3D"mailto:l4stpr0gr4m@gma=
il.com">l4stpr0gr4m@gmail.com</a> wrote:<br>
</div><div class=3D"quoted-text">&gt; From: Kangmin Park &lt;<a href=3D"mai=
lto:l4stpr0gr4m@gmail.com">l4stpr0gr4m@gmail.com</a>&gt;<br>
&gt;<br>
&gt; enum RT_RF_TYPE_DEFINITION on rtl8723bs/include/rtw_rf.h<br>
&gt; is different from enum tag_HAL_RF_Type_Definition on<br>
&gt; rtl8723bs/include/HalVerDef.h<br>
&gt;<br>
&gt; So, update them to be the same reference from<br>
&gt; enum rf_type on rtlwifi/wifi.h which recent version.<br>
&gt;<br>
&gt; As a result, ODM_RF_TYPE_E needs to be updated as well<br>
&gt; Therefore, it is updated reference from enum odm_rf_type<br>
&gt; on rtlwifi/phydm/phydm_pre_<wbr>define.h too.<br>
&gt; And update some additional code to check more<br>
&gt; chip versions that resulted from it.<br>
&gt;<br>
&gt; Also, fixed some space required errors and<br>
&gt; line over 80 characters warnings by <a href=3D"http://checkpatch.pl" r=
el=3D"noreferrer" target=3D"_blank">checkpatch.pl</a>.<br>
<br>
</div>Don&#39;t do this.=C2=A0 It&#39;s considered unrelated white space ch=
ange and it<br>
makes the code hard to review.<br>
<br>
To be honest, I don&#39;t know the code well enough to say if this patch is=
<br>
a good idea generally...=C2=A0 It seems risky and I wish someone would test=
<br>
it or a maintainer would Ack it.<br>
<br>
regards,<br>
dan carpenter<br>
<br>
</blockquote></div><br></div></div></div>

--001a1148cede4751ce05649d90df--
