Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeCZQ2M (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:28:12 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:52500
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751157AbeCZQ2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:28:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v2] Documentation/CodingStyle: Add an example for braces
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <152114372879.3142.8833111074324091904.stgit@taos>
 <20180321091701.7d56445d@lwn.net> <87woy4iide.fsf@intel.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <724fc548-0e40-11a3-2a9b-3dd0db0de880@amd.com>
Date: Mon, 26 Mar 2018 11:28:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87woy4iide.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM5PR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:3:16::19) To BY2PR12MB0693.namprd12.prod.outlook.com
 (2a01:111:e400:52e0::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7467b8e-4913-4c55-00f7-08d593368e8a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;3:iA/LH0+bZZtfj7NIiedyHBfIEP0ZifM8D7IUVXhxULPORQDas+kfro3TfjM1qBR7koSQeo3WXNyc5cC50ymxstu+aqEOw7iT5woV3C2QwLptBNGJkBK5wNSKaEZYlnrI599pcI7xDpDFDPvPz8DuOwYWrwe9TWXAxdb4o3KkXpML28zQUtlgbkxYtB9e9u/BwumvhsuxNq6WCDW3MOwTStWsOIdOmS9fCXISa7S2L/8JbnHzcs8kOV0GG0SZUHLu;25:lo+AFIO2N6icykY4l3UBY0RAdIv0zf9+sfZB6dzs8URVLwJ+Cs+PREWel1fy0+llkUgy9chbP/olkrcP2fk6eFMeywz8jxbPK7vjGMMQVXrP1iLQTl0q22sE2vbXNHD1AIoR22qNID9IUcKe8E6JtPZZWffyKRpokwtUk9Zf5wS7buzEwuM7jToojV7SsEI8vpXEpkWx38cqBC5/sBYjpydH5+AyVkjvmhARYiWjtN1GomYXodnoFugHonRhmlzHdyo6FZg1chNptVbfFicpD7R4JHTQ9mZNc5bd5Ii3ZvNIju01x1ebfvmTKTUFBUHbxWKcOizpbwaAs7tNHNV+lA==;31:5w/C7MlBxQWlzZTA7k+3ItpcbsHtd6T3FH0kC2ML4HwrFrYfvn61QZNkKLh2rGMmgbjwJYSGtNc8ds8+0/h7mPxyPsmRyQKpMZHAZHWcC5attN4mmYMSWCjDGCBWVtJX3Fr5bCvImDFU4dEn0DhliYh1E45dQn2aeijHBgBBZuF0jCwTuXSxLhcZw6ug0He5v1N18SNMfJMNwpSY7snVA+4sPtqyxy8mXyaOMzUkwg8=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0693:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:7k1BlEpMhZtybGWDleN9ynwqNBm7hVbrkHunyBF3ilnhospM4NxhvXR434XSrz2r6fRjph4WXuitRu7a0/NR2av3/WGAn8/MkHosMjxRZNxZHNPWQmV+ZhqBUWqcvbyw7hwvmmbBbccyGmeQ2vNMHe5JWaxS6Ou7/u0FSt0pMcSVILKRQIDiKk1wel0ChZQjG6LdP1WwNiG7WmfYiSzfxQXYUFA/3z/nE0gqElO6oPXS2qqJN7mVgbkC7yuDDNx7WkMA6UtKGgVzEJBYwjSVbCaq7WZ/9MUDhmP71xKpYegJ5n+KPCx6YoECwl1ii5mNI8MmB3xGr3vyUNfFOhyuuDq3GWiLEtX7NShy/RKp+6cpe3vpKS5Is8B8lO5cUfR/WhXckSxCLVjmyqgoEsor8adgsl/5VQ+oxvmQnlbHhtv0pNPHdLdCpsbYv2n+dZ7lEebWoDWZ0oxa3UrBpe/SEw97ojFrWLHK1Q1y0TdEXX1buTHqJ3lsiAne+9jF9yZE;4:K+ujIy5OZ9Eu0InRzfK4TLRQNdZ9vOBmKKUYkzHT0LbIieKMo2JFsnzNPO41zp1ZbuWXJZ9YdtML+mCxovtkF8fMKcyoSGx6KHIVE5bbsT4SG2u+LcHAqbEqxBYN38FSB09bY9G43AE8/mvsDvu4+HbPUybDBTHJxdjNZkVse6pOOw6yciuTNoRo1oy70E/YAKP7g5y3RrJVOeGkNwsQNG0ez+FK+JRTAUJ2yprdAC5evXO+tLiB7VpxaZTKBvqRt+6kK8QfqNgqMEiI1B+JJB9MjKanaoAi8WrL9mbm6S6+T7iTZJ13AzG/LCy9V9i+
X-Microsoft-Antispam-PRVS: <BY2PR12MB06931E112A32847054D17064FDAD0@BY2PR12MB0693.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR12MB0693;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0693;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(346002)(39380400002)(396003)(376002)(199004)(189003)(47776003)(25786009)(6666003)(106356001)(53936002)(65956001)(65806001)(6486002)(6246003)(229853002)(64126003)(230700001)(6116002)(66066001)(77096007)(26005)(386003)(476003)(486005)(486005)(67846002)(86362001)(7736002)(53546011)(4326008)(23676004)(76176011)(52116002)(2486003)(3846002)(52146003)(68736007)(16526019)(186003)(16576012)(8676002)(110136005)(65826007)(478600001)(446003)(11346002)(58126008)(316002)(97736004)(305945005)(72206003)(956004)(5660300001)(81166006)(81156014)(2616005)(8936002)(2906002)(31696002)(36756003)(105586002)(50466002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0693;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjkzOzIzOjAwRGxkc21Sb0pVV3NSSFJhc01yc0Z5U1pB?=
 =?utf-8?B?ZmNFVVNyU0JQdDNRYnRZZHpSV2xCek1YVnErc0FDSjh0WXM0VWFmbVRXak40?=
 =?utf-8?B?TmVwbUl0T1hUOHNESllOWVV2WVhDMTNlUE1POU9wOUEyTktMVC9jdmFnT3NX?=
 =?utf-8?B?UlVqUmFUNEZrNTdSdjRSSWVWcmpEajMwc1h3a1RDemY5amZiTW1wSWJRV1U5?=
 =?utf-8?B?bExwNkRGUTdISTVJTDdSeU9ZbGVCVGNXUGxOMVBVRzFTclhUZ0ZxSGdLUk9O?=
 =?utf-8?B?dytWeE9hdU1ySGE3dWNVd0xRNWVsdDI5bVFRZy92azY1aE1sR0JEcEUrQWR5?=
 =?utf-8?B?bDQybE4yTnlrNEg5dVQyUlY0SW1pRHg0MDBHb2dSeVBDWEJSM204L09wWTYx?=
 =?utf-8?B?cnM2NjhlU3JndEtjcmZqMVBidTRuVzFHL3JIVURkMXRFYzBFeVY4U0ZCU1Jh?=
 =?utf-8?B?SjdjMUtOWjVpQ1p1aHZBSkNpZmNITm1mNGtvdGFieWUrQmtMOEQ0WjF2OEhs?=
 =?utf-8?B?RXhmN3B4QkpMZWZQTzJ3Q2ZGaDFreHF5eERjZkJIMEd3OFpOUW04K3EwY21u?=
 =?utf-8?B?RlE0M2JwQi9qbEt1TXp5K0lqQzNiNERFWmx6Y2Q5a2hDSzBLOWJSRlJkZzN0?=
 =?utf-8?B?YmZVanREa21rUTlPYUcyNzJSUEcyV2FXVFVvV2c4Tks4L3pLZzdtZU5KbEdK?=
 =?utf-8?B?c1JicnlLWDZYdUE0Yjc1dldubnEwOG1PTkhqM2VlQi9kRmhseUJ1c2pQTnNY?=
 =?utf-8?B?T2pweENLTUUzQ21RcTZkQ0R1UnNUU0Q3MElmWjZ5VkVkMnc2ckMxVFlFeGtj?=
 =?utf-8?B?UFErY3MxQm9GVU5EdG15VXU1b2txVHhzS25BbERsZGh4aTlEemVsVjRtQURJ?=
 =?utf-8?B?UER0ZkdoR0I0ZFUvZm9zTnJYdWZWZTBKZlV1SWFWRG4ra050RFhUcktBcU9O?=
 =?utf-8?B?VTQvbndRaEJxeUFLUzJidDJQanZHeno4L2VPdXB6ZFV3YXlabHpxcWluVlVH?=
 =?utf-8?B?K2VWSnRPUGl3VUJuOHpmMitQNlhFOS9hZitJZGVLc29kdHJYeG1Ya2REQlN0?=
 =?utf-8?B?KzRJcWR6RzRrMFAvWFlEdStsMy81Mnc5SWdpckRRSnRybnpxaGFyQUloeUVz?=
 =?utf-8?B?L0ZFeUxoR3ErSGZLOEJKbnJhNEZWRU1FODlSTDg5cy9PQW1GUS9xbWw2WmhH?=
 =?utf-8?B?LzlHVHRYL0dFcGRNaDJtNnhjN1MvcjhHRGovS2lXc0wwMk5NK0NoL2RiQk5n?=
 =?utf-8?B?THdyZVRwZEMyWWYyd1ZnQnJFUXhFOFhUSWwwWmlVeXBkeUFlYXZlQnN0bDhO?=
 =?utf-8?B?VmZ0Zll5RE4vaUx6ZzhnRUhUMTZhWXBGcWYxdWhaWUFLRGdOUGhEKyt5eERu?=
 =?utf-8?B?MzlHcWhWdkZIMTBRYmRTYzNaditoOVdQaTB1ZlNLVXJyNkRDVzlGVldIcGRu?=
 =?utf-8?B?bDJudWpqdUJqcWU5dU0xTCtuSk9LZGtqNnoxSjlSRHR2dEY3OXNhaFBWZXNl?=
 =?utf-8?B?Qmgxd2xodzA5Mm4zejBSSDdNb09oYmNxWm12TmxET1E1bUpVektLSkJ0Yy9o?=
 =?utf-8?B?L1lZK0FJeWlrbU9Vb3dUa2tPeElyQVFKSUY0M1ZJNlhCdlVxd1VBbmtqQ0ZD?=
 =?utf-8?B?MHUwbG50SEYyQWh2WVZ2MkJoZ1o4S1FNYWFLUWxLbmpUQjBWTWpxOUswRDRS?=
 =?utf-8?B?aStIMU1mYURSN25kaC85SlQxN090L3YwZ3EwVHBibUJVczE2THlydmVXRXBs?=
 =?utf-8?B?bzdrN2tGcTdGN1BTRUpwTUR5SWgvMkJIVXdZdWJOdVoydkVFdFBKUGJEVCt1?=
 =?utf-8?B?ZnFlM0VpSmpoZWlxTTdtbWtIdUdjWVZ4UnJjQXRzMldPbkpBN3FPZVY0czZI?=
 =?utf-8?B?UU11T3JWSVh1YVRGTnJvRnR6TDlxQ2lSMXhodng0MzZRZUhEYjRJK2hDRzBN?=
 =?utf-8?B?eUlsSEJqVlE2MlpkbXlvWWt2aHV2TUJWOEJxUml6YmNMeDRTbjhJZlF5MGhl?=
 =?utf-8?Q?d26hxw?=
X-Microsoft-Antispam-Message-Info: I7sNwPbbQHAeMYlIMg9Xq3dPJQOcdgQBsr50eeUTRFflqBFifwCaRNGBKeLkXbPMkE7QiGU7VUfBb5uN2Y7RwmLcRfOH7PlpeH6LCm84h2S8bVrEvGqUlA5iy3bROMZTpSdlRtHK/H75VxHi8WD+bV41TmAW4eEdjkTmXhYARKtdzTK/IHW5gK8dKrlSyXX9
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;6:uPdCfrK2mEwhFwHt4Um6hqb7+F2ayGDUk9w3+ZNMC3gwDho6jRMbLv2my7273r4oEXZ56ojYtTTSergE96vxA3XfAB0OxAPozPmGUaR9cjYsS9DmLn9sEOMqp7TUkcRbt2aAbX9/MirRhS7dQN1JHbyPM5EfVHsDbWAT7PED4ZWHpzR7VyIYXBJzTl10a82M7paHrlnEGcgPllgeuRhzraG2LzdrC2dQPKyNlLRPct3IP5NyGhnNn7iMOiIEnA1+Y+0U1LMtRM7aVub/yskYNW2dVBU87SnWzRNO5tKft0ygPhx5aUIrScQmZuZs5V9hIv/nj/JB3zMLenfYZNzvMm6/oDcTrbwbKEXcovW4tWA4JY+DvxGr8cetLFo5AwKSO5uZIuk/jYWEHnbWJOip8x8Q1PnZ/dL/7ivTnBOYtrAaqSegDqbs7D83TFP4+PFT2LBm/mUy0jYQjUnxLFs3XQ==;5:yaVM89dEQgDk1ya8yTu2P49u2+spc8em5bTakq9hkSjl2lIjiHokoxfJtaC5ZP3hfCQvQ1RV8NQvFftLri69s8F30t5V9yN0iTRJwQG2Wjr+iYVg3YlfRDwafV/trMjyY1roaeRuCY1H1/YhuMzEJ5sFGcFCZYlmGTKm+1mXg9w=;24:SxaihWWMbFz7KEezI9GC02SGpmU1kyL7YV9rrn4AvneX8sdAVVJ3B7u4V5feFdDK6bLKzdpPo44m5P9zVvodVriYpZz2nNtjLKay+snmLB8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;7:QR4/+4e5JPhSHZrA+IDv8wB+wNhhRv975WQnKWHsM05D9kj+DEUETsKIzPham6Q4NOyrisRtzFcT6/e5kIVdOAvhhu6JTgdNjKbm2pc2mdNQJvHeGSiZ9dNMhsSt6nvWCeDu3PNRR3ZTeS2/7r4ULyItAGgCV/vXe3k3v9gw9CXiAhpmXdzHi1Eunay/cr/dezDOUbV4FODAapPNbFnw++4YGFGj6IwL5hm43MNIwZOzOlBOyMMlyzmEuATTmnaM;20:Cle0Z55U2zs8efPb/VvTpnUbNWDPZGcTmpjWmTQ8iDzycgLrbZQeGzgQq/TwCWz867fn5jc53MNDTK4TJ+Hbq52BZUeAP9ZZuLnu+zs5RS7+Gbe29eQ83yiA8NU4TNKkShGRcUiF3OH5h4UEMKaauOu+rUE5PDVdZbrfkzR7ecuekE8qawHqrWPGCVUOkdjH0Wqua61hGz1H+ZXfN01IPFgJ36Xn/sL17Ypj2qUTpvjIc4B8DEwrxaOmQNhkDoC7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 16:28:06.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7467b8e-4913-4c55-00f7-08d593368e8a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0693
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/2018 04:12 AM, Jani Nikula wrote:
> On Wed, 21 Mar 2018, Jonathan Corbet <corbet@lwn.net> wrote:
>> To head that off, I think I'll apply your first version instead, sorry
>> Jani.
> 
> No worries.
> 

Submitting a v3 because the example could better illuminate the options 
by using loop construct inside of an if, addressing Jani's point but 
without opening the door to later criticism.

I also like the verbage in v2/3 better, but I'll let Jonathan make the call.

BTW which tree should these be developed against? I used torvalds, but 
I'm not entirely sure that was the proper one?

Gary
