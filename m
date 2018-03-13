Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520964163; cv=none;
        d=google.com; s=arc-20160816;
        b=oGtYJOFz4Ci/V6Bx9521lyb1TsDApDyHNiO91nZJDl9rBzqCmrdgN/8VgQ2AU1WhXv
         4rNkHmlrn9n24niXlzueezgtKEvlrPPYB/7Cx41qbbLgsc2IhfXqkgbVTo4XvaMX3PH8
         Sgu8340+cK2y8qF3VL/eRA9d4iHErAR77nCOP4qe8kTJsmgAn1vhbTYXZonrn6zC3nT5
         oMukoF7r5P6zf3MOYKx4/sEK/WQMJitj9jjwr3q3orqHXS7U6v2OQ0/RZCUeucoi+AID
         LA6vgz2bFMyoDfiBd/KxYMxLuTKTqUuF76VF1sN8CbIAAF0PhReUpPI9xkRlroKQFLYT
         /QGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=XulWEs7QSAWTs3KcsYIcONYvR1cRa68T2Ok/985BA+k=;
        b=xrFqxqUhGjdX9r0XoS//sFxTDazbZR7YLpSlzgzzTw2j8xtArYUl0bs7mcF3E/yCgK
         2po4RNpz1fM3qu68mk07eUIMTjsZTF4RyXyJOSwk8HDk/a5YKdUcOeUPUwfGfF286iHE
         M4Fawu547p4iPlZ86dwiRJpp2EkIMfZsfhKu+HPrhcFv8yTPC7oheJyWMZuP0tIliEvZ
         SwSFpf2pHjVJHylzEx9RXaHCIYKqGA+pBsDYgCYSgprE3r9nyWJnN0wW+ORRkQc7PURN
         SahxeU6wUwTOhUyKlb2cRftf+kF0p7bHK3ETfpqkteYCb8Pa94bWAWd6KNiS9aWce75I
         uHGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uwMrDtOJ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=bGWNNlob;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uwMrDtOJ;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=bGWNNlob;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELtfxBpXzCgjb+BF0hkBoqTTZvNv7JsfDQQd7WVfyuqXSKT6MfdnCFbb4bi25Gp3TDLIfn79Po3Ttp734+dhSYU=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180313165527.24038-1-christian.brauner@ubuntu.com>
References: <20180313165527.24038-1-christian.brauner@ubuntu.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 13 Mar 2018 11:02:42 -0700
X-Google-Sender-Auth: _PcKsQEOFzluZLUCyB2vuezbbL0
Message-ID: <CA+55aFw3fO1o+w_EPEqYzJ+p4NELK_9g0tFx6fdEZ7mUGV8=mQ@mail.gmail.com>
Subject: Re: [PATCH 0/4 v5 RESEND] devpts: handle bind-mounts correctly
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Containers <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594842295484827893?=
X-GMAIL-MSGID: =?utf-8?q?1594846518716706991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 9:55 AM, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This is the fith iteration of this patch. Per-patch changes are
> summarized in the individual patches:

I don't see anything I react to any more. So Ack from me.

             Linus
