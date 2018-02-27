Return-Path: <smfrench@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519754165; cv=none;
        d=google.com; s=arc-20160816;
        b=FRKlRXxXOkAQqvroSlmoV8QI8/7jIsgVJhbjS82gvFt20gxCH5zBaGK8JsknaZxix/
         8Y1x9Np9piG9FyWsxQk+K5AgR0JA10AJONsSfJQFCc+qhNghtcU/evFOwLhjrWL6a8LB
         p9Dchi0IGlPKKukcVs5qz/6dKGy6czsqRAsbibNGXWog4fhh+sX6/sQTyXiAG994zzRm
         IIPAFI13LcJvhzGHbqIXAYPJX5a5gT+QbRgQvrRgtH5eMhSZpcrSQYsZrBjPJKfWfiPs
         F10VIwXCaoYslepcVAESRADGhkfAD+Jnk7bkHhO+t4Wsp/k/LcquNRL1qZmlHQm0Nfau
         hJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eq7CQO4/KEw+FsLu8tG2cFc6zDo5ne7Ia1HUTP6zRLI=;
        b=s2SmaOZPqnFfjqMsCrK29Cs+kApDeOq9e9RYyggsfJ/0yCcKYDPKkXHUUZkuB20DgJ
         XyO+RsLVEJzueG4ER5D63HPhfvIKPHu1uuPotQUhVoKlT5hDvrsrXT0TGRVZlumMBLTP
         P7b0HefDSizKviqXhTo3Le/vySJl0IYm3w6uRQoCS92Bivs4+BoTbN0SgmI++gzCfoP6
         CDGMIRtga1uOkfqhuTbP7tiLhf9e845POzDM86WiQ5UD3ZONbnfCXgldYIIhj12K2QDF
         w8yHPYoyUUppCItL8qoVrrDlsiOIIVehKe+rocrozOvufZgyJnVAq0oyKLEYWPwEGlZf
         Xl4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XNw3dX55;
       spf=pass (google.com: domain of smfrench@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=smfrench@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=XNw3dX55;
       spf=pass (google.com: domain of smfrench@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=smfrench@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuTlUJsyWXPbsuy1ePuIlI2y7AVFahihzxxPD0Xadidc+IihH6nN5PGa3po9wSuUnsVRDXKEZpmVmNSF0XthCA=
MIME-Version: 1.0
In-Reply-To: <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu>
References: <20171031095530.520746935@linuxfoundation.org> <20171031095531.633196173@linuxfoundation.org>
 <97340c9a-0ea2-0d3d-cf26-58c799d76cae@mageia.org> <20171101151803.GB31285@kroah.com>
 <4ba67095-4075-688f-d3fb-157847aee4d9@csail.mit.edu> <28ffc363-5140-5685-d288-6e3dc07c6369@csail.mit.edu>
 <20180227085428.GA16879@kroah.com> <b20cbd94-ce9b-cb2c-dc95-a6821376823f@csail.mit.edu>
 <20180227124050.GB31888@kroah.com> <6bca5a97-f581-86b8-12ad-77147619d519@csail.mit.edu>
From: Steve French <smfrench@gmail.com>
Date: Tue, 27 Feb 2018 11:55:44 -0600
Message-ID: <CAH2r5mvhpuE_Y=J0zyarCEvgxuOUoyO5i=nkJap7deuLT_F=jQ@mail.gmail.com>
Subject: Re: [PATCH 4.13 28/43] SMB3: Validate negotiate request must always
 be signed
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Backlund <tmb@mageia.org>,
	=?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
	LKML <linux-kernel@vger.kernel.org>, Stable <stable@vger.kernel.org>,
	Ronnie Sahlberg <lsahlber@redhat.com>, Pavel Shilovskiy <pshilov@microsoft.com>,
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/alternative; boundary="94eb2c1bc1022759f105663557af"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1582766661007473179?=
X-GMAIL-MSGID: =?utf-8?q?1593577744431006479?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--94eb2c1bc1022759f105663557af
Content-Type: text/plain; charset="UTF-8"

This shouldn't be too hard to figure out if willing to backport a slightly
larger set of fixes to the older stable, but I don't have a system running
4.9 stable.

Is this the correct stable tree branch?
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/?h=linux-4.9.y



On Tue, Feb 27, 2018 at 11:45 AM, Srivatsa S. Bhat <srivatsa@csail.mit.edu>
wrote:

> On 2/27/18 4:40 AM, Greg Kroah-Hartman wrote:
> > On Tue, Feb 27, 2018 at 01:22:31AM -0800, Srivatsa S. Bhat wrote:
> >> On 2/27/18 12:54 AM, Greg Kroah-Hartman wrote:
> >>> On Mon, Feb 26, 2018 at 07:44:28PM -0800, Srivatsa S. Bhat wrote:
> >>>> On 1/3/18 6:15 PM, Srivatsa S. Bhat wrote:
> >>>>> On 11/1/17 8:18 AM, Greg Kroah-Hartman wrote:
> >>>>>> On Tue, Oct 31, 2017 at 03:02:11PM +0200, Thomas Backlund wrote:
> >>>>>>> Den 31.10.2017 kl. 11:55, skrev Greg Kroah-Hartman:
> >>>>>>>> 4.13-stable review patch.  If anyone has any objections, please
> let me know.
> >>>>>>>>
> >>>>>>>> ------------------
> >>>>>>>>
> >>>>>>>> From: Steve French <smfrench@gmail.com>
> >>>>>>>>
> >>>>>>>> commit 4587eee04e2ac7ac3ac9fa2bc164fb6e548f99cd upstream.
> >>>>>>>>
> >>>>>>>> According to MS-SMB2 3.2.55 validate_negotiate request must
> >>>>>>>> always be signed. Some Windows can fail the request if you send
> it unsigned
> >>>>>>>>
> >>>>>>>> See kernel bugzilla bug 197311
> >>>>>>>>
> >>>>>>>> Acked-by: Ronnie Sahlberg <lsahlber.redhat.com>
> >>>>>>>> Signed-off-by: Steve French <smfrench@gmail.com>
> >>>>>>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>>>>
> >>>>>>>> ---
> >>>>>>>>   fs/cifs/smb2pdu.c |    3 +++
> >>>>>>>>   1 file changed, 3 insertions(+)
> >>>>>>>>
> >>>>>>>> --- a/fs/cifs/smb2pdu.c
> >>>>>>>> +++ b/fs/cifs/smb2pdu.c
> >>>>>>>> @@ -1963,6 +1963,9 @@ SMB2_ioctl(const unsigned int xid, struc
> >>>>>>>>        } else
> >>>>>>>>                iov[0].iov_len = get_rfc1002_length(req) + 4;
> >>>>>>>> +      /* validate negotiate request must be signed - see MS-SMB2
> 3.2.5.5 */
> >>>>>>>> +      if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO)
> >>>>>>>> +              req->hdr.sync_hdr.Flags |= SMB2_FLAGS_SIGNED;
> >>>>>>>>        rc = SendReceive2(xid, ses, iov, n_iov, &resp_buftype,
> flags, &rsp_iov);
> >>>>>>>>        cifs_small_buf_release(req);
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>> This one needs to be backported to all stable kernels as the
> commit that
> >>>>>>> introduced the regression:
> >>>>>>> '
> >>>>>>> 0603c96f3af50e2f9299fa410c224ab1d465e0f9
> >>>>>>> SMB: Validate negotiate (to protect against downgrade) even if
> signing off
> >>>>>>>
> >>>>>>> is backported in stable trees as of: 4.9.53, 4.4.90, 3.18.73
> >>>>>>
> >>>>>> Oh wait, it breaks the builds on older kernels, that's why I didn't
> >>>>>> apply it :)
> >>>>>>
> >>>>>> Can you provide me with a working backport?
> >>>>>>
> >>>>>
> >>>>> Hi Steve,
> >>>>>
> >>>>> Is there a version of this fix available for stable kernels?
> >>>>>
> >>>>
> >>>> Hi Greg,
> >>>>
> >>>> Mounting SMB3 shares continues to fail for me on 4.4.118 and 4.9.84
> >>>> due to the issues that I have described in detail on this mail thread.
> >>>>
> >>>> Since there is no apparent fix for this bug on stable kernels, could
> >>>> you please consider reverting the original commit that caused this
> >>>> regression?
> >>>>
> >>>> That commit was intended to enhance security, which is probably why it
> >>>> was backported to stable kernels in the first place; but instead it
> >>>> ends up breaking basic functionality itself (mounting). So in the
> >>>> absence of a proper fix, I don't see much of an option but to revert
> >>>> that commit.
> >>>>
> >>>> So, please consider reverting the following:
> >>>>
> >>>> commit 02ef29f9cbb616bf419 "SMB: Validate negotiate (to protect
> >>>> against downgrade) even if signing off" on 4.4.118
> >>>>
> >>>> commit 0e1b85a41a25ac888fb "SMB: Validate negotiate (to protect
> >>>> against downgrade) even if signing off" on 4.9.84
> >>>>
> >>>> They correspond to commit 0603c96f3af50e2f9299fa410c224ab1d465e0f9
> >>>> upstream. Both these patches should revert cleanly.
> >>>
> >>> Do you still have this same problem on 4.14 and 4.15?  If so, the issue
> >>> needs to get fixed there, not papered-over by reverting these old
> >>> changes, as you will hit the issue again in the future when you update
> >>> to a newer kernel version.
> >>>
> >>
> >> 4.14 and 4.15 work great! (I had mentioned this is in my original bug
> >> report but forgot to summarize it here, sorry).
> >
> >
> > Then what is the bugfix that should be applied here in order to keep
> > things working with these patches applied?
> >
>
> That would be the one mentioned in the subject line of this thread :)
> However, a working backport of that fix is not available for 4.4 and
> 4.9, hence the trouble.
>
> It looks like we are reconstructing elements of this email thread all
> over again, so let me quickly summarize the status so far:
>
> In 4.14/4.15/mainline,
> - commit 0603c96f3af50e2f9 (SMB: Validate negotiate (to protect against
>   downgrade) even if signing off) caused mount regression with SMB v3.
>
> - commit 4587eee04e2ac7ac3 (SMB3: Validate negotiate request must
>   always be signed) fixed the issue.
>
> - [ There was a lot of code churn in the CIFS/SMB codebase between
>     these two commits in mainline. ]
>
> In this email thread, you backported the fix to stable 4.13. Thomas
> noticed that the problematic commit had also made it to stable series
> such as 4.4 and 4.9, and requested a backport of the fix to those
> trees as well. However, a straight-forward backport of the fix to 4.4
> and 4.9 breaks the build, so no fix was available for those kernels.
>
> I investigated this and tried to produce a working backport of the fix
> to 4.4 and 4.9, but didn't succeed, despite trying several variations
> as well as suggestions from Aurelien [1][2]. So, given that there is
> still no known fix for the mount regression on 4.4 and 4.9 stable
> series at this point, I decided to request a revert of the problematic
> commit that caused the regression in those kernels.
>
> [1]. https://lkml.org/lkml/2018/1/3/892
> [2]. https://lkml.org/lkml/2018/1/29/1009
>
> Regards,
> Srivatsa
>



-- 
Thanks,

Steve

--94eb2c1bc1022759f105663557af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This shouldn&#39;t be too hard to figure out if willing to=
 backport a slightly larger set of fixes to the older stable, but I don&#39=
;t have a system running 4.9 stable.<div><br></div><div>Is this the correct=
 stable tree branch?=C2=A0 =C2=A0<a href=3D"https://git.kernel.org/pub/scm/=
linux/kernel/git/stable/linux-stable.git/log/?h=3Dlinux-4.9.y">https://git.=
kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/?h=3Dlinux-=
4.9.y</a><br><div><br></div><div><br></div></div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Tue, Feb 27, 2018 at 11:45 AM, Sri=
vatsa S. Bhat <span dir=3D"ltr">&lt;<a href=3D"mailto:srivatsa@csail.mit.ed=
u" target=3D"_blank">srivatsa@csail.mit.edu</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 2/27/18=
 4:40 AM, Greg Kroah-Hartman wrote:<br>
&gt; On Tue, Feb 27, 2018 at 01:22:31AM -0800, Srivatsa S. Bhat wrote:<br>
&gt;&gt; On 2/27/18 12:54 AM, Greg Kroah-Hartman wrote:<br>
&gt;&gt;&gt; On Mon, Feb 26, 2018 at 07:44:28PM -0800, Srivatsa S. Bhat wro=
te:<br>
&gt;&gt;&gt;&gt; On 1/3/18 6:15 PM, Srivatsa S. Bhat wrote:<br>
&gt;&gt;&gt;&gt;&gt; On 11/1/17 8:18 AM, Greg Kroah-Hartman wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt; On Tue, Oct 31, 2017 at 03:02:11PM +0200, Thomas B=
acklund wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Den 31.10.2017 kl. 11:55, skrev Greg Kroah-Har=
tman:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 4.13-stable review patch.=C2=A0 If anyone =
has any objections, please let me know.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ------------------<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; From: Steve French &lt;<a href=3D"mailto:s=
mfrench@gmail.com">smfrench@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; commit 4587eee04e2ac7ac3ac9fa2bc164fb<wbr>=
6e548f99cd upstream.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; According to MS-SMB2 3.2.55 validate_negot=
iate request must<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; always be signed. Some Windows can fail th=
e request if you send it unsigned<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; See kernel bugzilla bug 197311<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Acked-by: Ronnie Sahlberg &lt;<a href=3D"h=
ttp://lsahlber.redhat.com" rel=3D"noreferrer" target=3D"_blank">lsahlber.re=
dhat.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Steve French &lt;<a href=3D=
"mailto:smfrench@gmail.com">smfrench@gmail.com</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Greg Kroah-Hartman &lt;<a h=
ref=3D"mailto:gregkh@linuxfoundation.org">gregkh@linuxfoundation.org</a>&gt=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0fs/cifs/smb2pdu.c |=C2=A0 =C2=
=A0 3 +++<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+=
)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; --- a/fs/cifs/smb2pdu.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +++ b/fs/cifs/smb2pdu.c<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; @@ -1963,6 +1963,9 @@ SMB2_ioctl(const uns=
igned int xid, struc<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 iov[0].iov_len =3D get_rfc1002_length(req) + 4;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 /* validate negotiat=
e request must be signed - see MS-SMB2 3.2.5.5 */<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 if (opcode =3D=3D FS=
CTL_VALIDATE_NEGOTIATE_INFO)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 req-&gt;hdr.sync_hdr.Flags |=3D SMB2_FLAGS_SIGNED;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D SendRece=
ive2(xid, ses, iov, n_iov, &amp;resp_buftype, flags, &amp;rsp_iov);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 cifs_small_buf_=
release(req);<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; This one needs to be backported to all stable =
kernels as the commit that<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; introduced the regression:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; &#39;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0603c96f3af50e2f9299fa410c224a<wbr>b1d465e0f9<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; SMB: Validate negotiate (to protect against do=
wngrade) even if signing off<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; is backported in stable trees as of: 4.9.53, 4=
.4.90, 3.18.73<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Oh wait, it breaks the builds on older kernels, th=
at&#39;s why I didn&#39;t<br>
&gt;&gt;&gt;&gt;&gt;&gt; apply it :)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Can you provide me with a working backport?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Hi Steve,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Is there a version of this fix available for stable ke=
rnels?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Greg,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Mounting SMB3 shares continues to fail for me on 4.4.118 a=
nd 4.9.84<br>
&gt;&gt;&gt;&gt; due to the issues that I have described in detail on this =
mail thread.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Since there is no apparent fix for this bug on stable kern=
els, could<br>
&gt;&gt;&gt;&gt; you please consider reverting the original commit that cau=
sed this<br>
&gt;&gt;&gt;&gt; regression?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; That commit was intended to enhance security, which is pro=
bably why it<br>
&gt;&gt;&gt;&gt; was backported to stable kernels in the first place; but i=
nstead it<br>
&gt;&gt;&gt;&gt; ends up breaking basic functionality itself (mounting). So=
 in the<br>
&gt;&gt;&gt;&gt; absence of a proper fix, I don&#39;t see much of an option=
 but to revert<br>
&gt;&gt;&gt;&gt; that commit.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; So, please consider reverting the following:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; commit 02ef29f9cbb616bf419 &quot;SMB: Validate negotiate (=
to protect<br>
&gt;&gt;&gt;&gt; against downgrade) even if signing off&quot; on 4.4.118<br=
>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; commit 0e1b85a41a25ac888fb &quot;SMB: Validate negotiate (=
to protect<br>
&gt;&gt;&gt;&gt; against downgrade) even if signing off&quot; on 4.9.84<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; They correspond to commit 0603c96f3af50e2f9299fa410c224a<w=
br>b1d465e0f9<br>
&gt;&gt;&gt;&gt; upstream. Both these patches should revert cleanly.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Do you still have this same problem on 4.14 and 4.15?=C2=A0 If=
 so, the issue<br>
&gt;&gt;&gt; needs to get fixed there, not papered-over by reverting these =
old<br>
&gt;&gt;&gt; changes, as you will hit the issue again in the future when yo=
u update<br>
&gt;&gt;&gt; to a newer kernel version.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; 4.14 and 4.15 work great! (I had mentioned this is in my original =
bug<br>
&gt;&gt; report but forgot to summarize it here, sorry).<br>
&gt;<br>
&gt;<br>
&gt; Then what is the bugfix that should be applied here in order to keep<b=
r>
&gt; things working with these patches applied?<br>
&gt;<br>
<br>
</div></div>That would be the one mentioned in the subject line of this thr=
ead :)<br>
However, a working backport of that fix is not available for 4.4 and<br>
4.9, hence the trouble.<br>
<br>
It looks like we are reconstructing elements of this email thread all<br>
over again, so let me quickly summarize the status so far:<br>
<br>
In 4.14/4.15/mainline,<br>
- commit 0603c96f3af50e2f9 (SMB: Validate negotiate (to protect against<br>
=C2=A0 downgrade) even if signing off) caused mount regression with SMB v3.=
<br>
<br>
- commit 4587eee04e2ac7ac3 (SMB3: Validate negotiate request must<br>
=C2=A0 always be signed) fixed the issue.<br>
<br>
- [ There was a lot of code churn in the CIFS/SMB codebase between<br>
=C2=A0 =C2=A0 these two commits in mainline. ]<br>
<br>
In this email thread, you backported the fix to stable 4.13. Thomas<br>
noticed that the problematic commit had also made it to stable series<br>
such as 4.4 and 4.9, and requested a backport of the fix to those<br>
trees as well. However, a straight-forward backport of the fix to 4.4<br>
and 4.9 breaks the build, so no fix was available for those kernels.<br>
<br>
I investigated this and tried to produce a working backport of the fix<br>
to 4.4 and 4.9, but didn&#39;t succeed, despite trying several variations<b=
r>
as well as suggestions from Aurelien [1][2]. So, given that there is<br>
still no known fix for the mount regression on 4.4 and 4.9 stable<br>
series at this point, I decided to request a revert of the problematic<br>
commit that caused the regression in those kernels.<br>
<br>
[1]. <a href=3D"https://lkml.org/lkml/2018/1/3/892" rel=3D"noreferrer" targ=
et=3D"_blank">https://lkml.org/lkml/2018/1/<wbr>3/892</a><br>
[2]. <a href=3D"https://lkml.org/lkml/2018/1/29/1009" rel=3D"noreferrer" ta=
rget=3D"_blank">https://lkml.org/lkml/2018/1/<wbr>29/1009</a><br>
<br>
Regards,<br>
Srivatsa<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature">Thanks,<br><br>Stev=
e</div>
</div>

--94eb2c1bc1022759f105663557af--
