Return-Path: <sezeroz@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518245251; cv=none;
        d=google.com; s=arc-20160816;
        b=bDAybNKGsL3kL1Cht9DFKEhKiFYZ9DG5QnZIGEL0guOhIgpbRt9J7RDocvD0/2856V
         TqxWVN67lM1yaCVVX5ifGuyk5ZCJqdOVcIkmWtZ/secF+f1oPkoVDVEOo8GIb97Ob48J
         gzTBti064cqiaDXfYYqH7juKfXXvMFJStPwTp4tDMKmhCYI0bum1swNAgnFn0rkjkz1q
         IaS+0nVsbwSA8fVS3X3aOOnAYPnWSIROWkxEmarXkkEuq8lStmyaf9k17r2J3ruB0omh
         ng09370fzbugt7jTwZsSkhblUVM2vpajYwxMxpZVC+/ddFMKz81fNj/cDcK6haP0EWlK
         fNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=K1MOKLA87BYKx1zbgvgvuReUm2UGqVaWZa5htj6TQ4c=;
        b=sTamIK4TFA4BPb2QC2R3yYWQPjaKEfQLGw207XK4VCTsob2VXNxAGdnUcuCR7Uy30V
         z5ET0JxZs+Gypwhi3F8wh+I5aJ9aHHgR8ick7G6SGx4kkoTzltqn+KAaUDckIjHi2D+J
         PiHf6z8Kb4d5r188pbSjGEpLA+ZNFpR5XUYjLt/c2AMk+LUobGSLpkbeuy1iVYiErvS5
         d91rCruoIcGQGgQ/rT2fskWAxF5BXiBkxvvpAIXkTh1IRBtDECgCsIf14F79vLxX85g2
         +8b93h/prDvF+cuwGTqfd+oP5xgWjd+2s4LWLyT+cZ+Vk5/5QjHwWORJZhPK8qsYonUQ
         7zFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Yrn2ogzV;
       spf=pass (google.com: domain of sezeroz@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sezeroz@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Yrn2ogzV;
       spf=pass (google.com: domain of sezeroz@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=sezeroz@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2243SeUkrFnqjqnnE/vncXGpKcXS0/nxJfHCIIFaH2TIhcrz6QkMCp4P3NelTCXtLJjdbUzd+XnqEAKto1f9cI8=
MIME-Version: 1.0
From: Ozkan Sezer <sezeroz@gmail.com>
Date: Sat, 10 Feb 2018 09:47:30 +0300
Message-ID: <CAA2C=vAC18VS3X7JScNT1204Jg36z90EHuhk0e0CUvnvj9Lu8Q@mail.gmail.com>
Subject: Re: [PATCH 4.15 00/23] 4.15.3-stable review
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931344572458017?=
X-GMAIL-MSGID: =?utf-8?q?1591995532837043198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 06:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.3 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Feb 11 13:39:20 UTC 2018.
> Anything received after that time might be too late.

I hope it's not too late for reverting 5b54eddd3920e9f6f1a6d972454baf350cbae77e
to fix the i915 "no reboot/no poweroff" regression:
https://bugs.freedesktop.org/show_bug.cgi?id=104805
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20180209&id=b5a756a722286af9702d565501e1f690d075d16b

--
O.S.
