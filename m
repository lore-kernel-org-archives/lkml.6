Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756823AbeDZVXi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:23:38 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:37105 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756527AbeDZVXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:23:35 -0400
X-Google-Smtp-Source: AIpwx4+P//6Yf5RO/j72+JPx4/wbly53XKvzajbiGV7pVY9yKFJEW9Fj4ifBJ/UBYCfqpGLcxsI7Tg==
Date: Thu, 26 Apr 2018 16:23:30 -0500
From: Andy Gross <andy.gross@linaro.org>
To: Evan Green <evgreen@chromium.org>
Cc: sfr@canb.auug.org.au, agross@codeaurora.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>, groeck@chromium.org
Subject: Re: linux-next: build failure after merge of the qcom tree
Message-ID: <20180426212330.GD25699@hector.attlocal.net>
References: <20180426084041.5cf81918@canb.auug.org.au>
 <CAE=gft6e6wo1nj+Rw5=f+UXxhx3Hof7Nt=E9+-OAzvvv8Gct1g@mail.gmail.com>
 <20180426145255.0141300e@canb.auug.org.au>
 <CAE=gft625-cWjBQXcNRumFRGrmF6nJDf0pAjBbG+gAAS_YXtWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft625-cWjBQXcNRumFRGrmF6nJDf0pAjBbG+gAAS_YXtWg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 04:42:17PM +0000, Evan Green wrote:
> > I suspect that just Linus' tree merged with the qcom tree would have
> > been enough to cause the failure.

Sorry for missing this in my testing.

> 
> 
> I've verified that the patch listed above fixes the issue for me. Andy, if
> it looks okay to you, go ahead an pull it in. Apologies for the trouble,
> and thanks Guenter for having builders that notice this stuff early!
> -Evan

Thanks for looking at this Evan.


Andy
