Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AG47ELsEzcGleSphVUR197Dz727d+bW7DpKGCj699fo+e8JYpRHa/Z8yA7Z/Uhb0f5ekTtVNDIvf
ARC-Seal: i=1; a=rsa-sha256; t=1520553298; cv=none;
        d=google.com; s=arc-20160816;
        b=BtMjCVKEnIxGQzRlGWgGaeDbhrwwBJfM0p0JHbKPNnKiCCQ54h2b83n1dxpPGDf2+m
         MziqLuw2cQQYMiK7CGelW83io7mM2T9JTY2LWRDZ8mqk0WuzOyG9TTWdfPrFUwaWLO9e
         iPyk05yfVtOpBi1ptyfVHhX6Og8XdHwiO8sZEQAxuzvXpFwd/6tvz+/jwGoeplkwBk0v
         h2/KvhXczVn8kDR8jadzqWpZiyD7M5jG0t7TcjvuvetOyIdpdPilksgIL6aGqOXokPsO
         RHl3KzkPrQOg4Sg6ED06y5X+TbdtBjUJhg/xFmtS+uNdBFymuZYk75Rj9VWBMrCnZNdE
         mdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=oW1Kjh6HwSI3kArU9N2BANVOJpGFV3Da4LJdtVyalHA=;
        b=JNm4EAIWgQp4cv+g9DU/GThQnNNXjV2KS8yKJCRCL+yNCpiIYUPQ7LG46jK9YiDVVR
         HKQq0O8ueCBb/yBoZIVOkcSeXJLSe9sTgYzVLC3NAG3WmJy9AVEE8Hi0woPVDojEKJDp
         Ui8dmJ75Kore2pioalwxJf3Mf21HzfJNJ4L/C4eBM8j+rz/SBrEeQh8YFN1ERcKAj0Px
         fs1fuHTO+TzNyCovE+6Cir9Z/D9csRvoScVlr7j3CHh/q31GKpNmLmE/0GyvEvOkwT2v
         JjvaKCQiY4MndWD5iiZTLERq9Pkg7Yyghqt5WGwHI4VuglDmHvjc5gTliZPTjDmAHPqG
         C5oA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="22887092"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: "Drokin, Oleg" <oleg.drokin@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, James Simmons <jsimmons@infradead.org>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Lustre Development List
	<lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 12/17] staging: lustre: remove unused flag from
 ptlrpc_thread
Thread-Topic: [PATCH 12/17] staging: lustre: remove unused flag from
 ptlrpc_thread
Thread-Index: AQHTsbW7DN2UgoRlFEiiSJxjTGyqoKPHlGgA
Date: Thu, 8 Mar 2018 23:54:56 +0000
Message-ID: <5E9E1F23-3BC8-4267-8B12-C1BBAF396F02@intel.com>
References: <151994679573.7628.1024109499321778846.stgit@noble>
 <151994708545.7628.17939519532029157797.stgit@noble>
In-Reply-To: <151994708545.7628.17939519532029157797.stgit@noble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.37.249]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18574A9865699545BB38F9DE73F48EEC@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780175626155956?=
X-GMAIL-MSGID: =?utf-8?q?1594415695171764814?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mar 1, 2018, at 16:31, NeilBrown <neilb@suse.com> wrote:
>=20
> SVC_EVENT is no longer used.
>=20
> Signed-off-by: NeilBrown <neilb@suse.com>

Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>

> ---
> drivers/staging/lustre/lustre/include/lustre_net.h |   11 -----------
> 1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/staging/lustre/lustre/include/lustre_net.h b/drivers=
/staging/lustre/lustre/include/lustre_net.h
> index 5a4434e7c85a..108683c54127 100644
> --- a/drivers/staging/lustre/lustre/include/lustre_net.h
> +++ b/drivers/staging/lustre/lustre/include/lustre_net.h
> @@ -1259,7 +1259,6 @@ enum {
> 	SVC_STOPPING    =3D 1 << 1,
> 	SVC_STARTING    =3D 1 << 2,
> 	SVC_RUNNING     =3D 1 << 3,
> -	SVC_EVENT       =3D 1 << 4,
> };
>=20
> #define PTLRPC_THR_NAME_LEN		32
> @@ -1302,11 +1301,6 @@ struct ptlrpc_thread {
> 	char				t_name[PTLRPC_THR_NAME_LEN];
> };
>=20
> -static inline int thread_is_init(struct ptlrpc_thread *thread)
> -{
> -	return thread->t_flags =3D=3D 0;
> -}
> -
> static inline int thread_is_stopped(struct ptlrpc_thread *thread)
> {
> 	return !!(thread->t_flags & SVC_STOPPED);
> @@ -1327,11 +1321,6 @@ static inline int thread_is_running(struct ptlrpc_=
thread *thread)
> 	return !!(thread->t_flags & SVC_RUNNING);
> }
>=20
> -static inline int thread_is_event(struct ptlrpc_thread *thread)
> -{
> -	return !!(thread->t_flags & SVC_EVENT);
> -}
> -
> static inline void thread_clear_flags(struct ptlrpc_thread *thread, __u32=
 flags)
> {
> 	thread->t_flags &=3D ~flags;
>=20
>=20

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
