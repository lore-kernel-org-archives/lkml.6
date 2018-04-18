Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx4+nxU9drT+5LnComBICbVzzKoTeEIVbcNtndQ9r558g5p1OTLluLPS77XfKnYsxvz14KSmo
ARC-Seal: i=1; a=rsa-sha256; t=1524083711; cv=none;
        d=google.com; s=arc-20160816;
        b=fL4GJNNbGTaVUOuR9ittvTrDjyB4JHjHU6SzJY7vITOo01aIZPbiPGrm10kN+awbmL
         gYQwORoWMrjZtAaZna7INduTrr27wc5hyWhJzj2oIONppFh0EpVXrg106ACkQf2W2uYc
         FYdMVFfXvv7+tp7uGD81MWEBqdwDQtHTLLoS9b5+vLBIhKK/tIJFngSHn5Wp6H7g3F6k
         ztw+8siDBqUQiUcYgiQai53ZZwOC3sSuMvEw1RXtMa5qipTF8xsChLytqXd3JU53LtFy
         gmu/rthl1kUSSdWjUycn5yRbyu6m8IQlvzkg18UdrEGVHeT3dTUgXjvZd6YWucL2TlCP
         9fuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Iu9P9fA4kzPIoeWaBP1YC8F6wlAs0NewqilGXoAvHJ0=;
        b=MtW/vYD7Q4hUYkLmi83hTFxiwk3FHbqGDRR8WxVnR+yAuuElvRvjPsPzvN42UWp/lJ
         zOfJ7A7C5Oob9dpDXo0ARkMMVaJsXBKzTlJGELh7bCrwBvn0BjEd8s+uSt4deMKGuf52
         2dOFZhv2qyIqI1dMh3X06+tcZC0oYGdqnyrZTqrV+BfDXpyCMR9E1J/pg+fXuHxUwM83
         +AZMoH+OFS9gDSsj1EppKF0Pj63oNKXYfuM4fzKf6c8YfSbWvCDNkvf3zQqpK1XQ8Gfe
         c0Sx2aNH2zRPbbZTGRWgSLY5cGT0nNaDgk9V6UMe+ZLwiZkHVYH5VXMuLcgcGuDvLdkq
         kjbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 18 Apr 2018 22:35:09 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH driver-core 1/2] test_firmware: Install all scripts
Message-ID: <20180418203509.GP30543@wotan.suse.de>
References: <20180404203712.zecit6po44qsde4c@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404203712.zecit6po44qsde4c@xylophone.i.decadent.org.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849376689365060?=
X-GMAIL-MSGID: =?utf-8?q?1598117602023394164?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 10:37:13PM +0200, Ben Hutchings wrote:
> List all the scripts invoked by fw_run_tests.sh, so that
> "make TARGETS=firmware install" keeps working.
> 
> Fixes: 29a1c00ce1df8 ("test_firmware: add simple firmware firmware test ...")
> Fixes: b3cf21fae1fe0 ("test_firmware: test three firmware kernel configs ...")
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
